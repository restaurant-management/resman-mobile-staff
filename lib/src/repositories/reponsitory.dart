import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/cartModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/discountCodeModel.dart';
import 'package:resman_mobile_staff/src/repositories/dataProviders/billProvider.dart';
import 'package:resman_mobile_staff/src/repositories/dataProviders/dailyDishesProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/userModel.dart';
import '../utils/validateEmail.dart';
import 'dataProviders/userProvider.dart';

class Repository {
  static Repository _singleton;

  static Repository get instance {
    if (_singleton == null) {
      print('Initialize Repository ...');
      _singleton = Repository._internal();
    }
    return _singleton;
  }

  factory Repository() {
    return instance;
  }

  Repository._internal();

  final UserProvider _userProvider = UserProvider();
  final DailyDishProvider _dailyDishProvider = DailyDishProvider();
  final BillProvider _billProvider = BillProvider();

  UserModel _currentUser;
  List<DailyDishModel> _dailyDish;
  BillModel _currentBill = new BillModel();
  CartModel _currentCart = CartModel.empty();

  BillModel get currentBill => _currentBill;

  UserModel get currentUser => _currentUser;

  List<DailyDishModel> get dailyDish => _dailyDish;

  CartModel get currentCart => _currentCart;

  Future<String> authenticate(
      {@required String usernameOrEmail, @required String password}) async {
    return await _userProvider.login(usernameOrEmail, password);
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(EnvVariables.PrepsTokenKey); // Delete token
    await prefs
        .remove(EnvVariables.PrepsUsernameOrEmail); // Delete username or email
    _currentUser = null;
    return;
  }

  Future<void> persistToken(String token, String usernameOrEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(EnvVariables.PrepsTokenKey, token); // Save token
    await prefs.setString(EnvVariables.PrepsUsernameOrEmail,
        usernameOrEmail); // Save username or email
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnvVariables.PrepsTokenKey) != null;
  }

  Future<void> register(String username, String email, String password) async {
    await _userProvider.register(username, email, password);
  }

  Future changeUserPassword(String oldPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    await _userProvider.changePassword(token, oldPassword, newPassword);
  }

  Future<void> fetchCurrentUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameOrEmail = prefs.getString(EnvVariables.PrepsUsernameOrEmail);
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    if (validateEmail(usernameOrEmail)) {
      _currentUser =
          await _userProvider.getProfileByEmail(usernameOrEmail, token);
    } else {
      _currentUser =
          await _userProvider.getProfileByUsername(usernameOrEmail, token);
    }
    print(_currentUser);
  }

  Future<String> uploadAvatar(File imageFile, String username) async {
    String fileName = username + '-' + DateTime.now().toString();
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<UserModel> saveProfile(
      UserModel user,
      String fullName,
      String phoneNumber,
      String address,
      DateTime birthday,
      String avatar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    return await _userProvider.editUserProfile(
        token, user.username, phoneNumber, address, fullName, birthday, avatar);
  }

  /// Daily dishes
  Future<List<DailyDishModel>> fetchDailyDishes() async {
    _dailyDish = await _dailyDishProvider.getAll();
    print(_dailyDish);
    return _dailyDish;
  }

  /// Cart repository
  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        EnvVariables.PrepsCart, jsonEncode(_currentCart.toJson()));
  }

  CartDishModel addDishIntoCart(DailyDishModel dish) {
    int quantity = 1;
    var cartDish = CartDishModel.fromDailyDish(dish, quantity: quantity);

    // Remove dish if it existed, then add a same new one with quantity increase one.
    int index = _currentCart.listDishes
        .indexWhere((_cartDish) => _cartDish.dishId == dish.dish.dishId);
    if (index >= 0) {
      quantity = _currentCart.listDishes[index].quantity + 1;
      _currentCart.listDishes[index].quantity = quantity;
    } else {
      _currentCart.listDishes.add(cartDish);
    }
    return cartDish;
  }

  void removeDishFromCart(int dishId) {
    _currentCart.listDishes
        .removeWhere((cartDish) => cartDish.dishId == dishId);
  }

  void changeDistQuantityInCart(int dishId, int quantity) {
    // Remove dish if it existed, then add a same new one with new quantity.
    CartDishModel cartDish = _currentCart.listDishes
        .firstWhere((e) => e.dishId == dishId, orElse: () => null);
    if (cartDish != null) {
      cartDish.quantity = quantity;
    }
  }

  void addDishNote(int dishId, String note) {
    // Remove dish if it existed, then add a same new one with new quantity.
    CartDishModel cartDish = _currentCart.listDishes
        .firstWhere((e) => e.dishId == dishId, orElse: () => null);
    if (cartDish != null) {
      cartDish.note = note;
    }
  }

  void addBillNote(String note) {
    _currentCart.note = note;
  }

  Future<DiscountCodeModel> addDiscountCode(String discountValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    DiscountCodeModel discount =
        await _billProvider.validDiscountCode(token, discountValue);
    _currentCart.discountCode = discount;
    return discount;
  }

  Future<void> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringCart = prefs.getString(EnvVariables.PrepsCart);
    _currentCart = CartModel.fromJson(jsonDecode(stringCart));
  }

  Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCart = CartModel.empty();
    await prefs.setString(
        EnvVariables.PrepsCart, jsonEncode(_currentCart.toJson()));
  }

  /// Bill
  /// Return bill model.
  Future<BillModel> createBill(int tableNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    List<int> dishIds = List<int>();
    List<String> dishNotes = List<String>();
    List<int> dishQuantities = List<int>();

    currentCart.listDishes.forEach((dish) {
      dishIds.add(dish.dishId);
      dishNotes.add(dish.note ?? "");
      dishQuantities.add(dish.quantity);
    });

    return await _billProvider.createBill(_currentUser.stores[0].id, token,
        tableNumber, dishIds, dishNotes, dishQuantities,
        note: currentCart?.note, discountCode: currentCart.discountCode?.code);
  }

  Future<BillModel> prepareBill(int billId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);

    return await _billProvider.prepareBill(token, billId);
  }

  Future<List<BillModel>> getAllBillStaff() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    return await _billProvider.getAllStaff(token);
  }

  Future<List<BillModel>> getAllBillChef() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    return await _billProvider.getAllChef(token);
  }

  Future<List<BillModel>> updateDiscountCode(String discountCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
  }

  Future<BillModel> getBill(int billId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    return await _billProvider.getBill(token, billId);
  }
}
