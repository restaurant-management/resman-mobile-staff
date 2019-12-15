import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:resman_mobile_staff/src/common/EnvVariables.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/cartModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';
import 'package:resman_mobile_staff/src/models/discountCodeModel.dart';
import 'package:resman_mobile_staff/src/respositories/dataProviders/billProvider.dart';
import 'package:resman_mobile_staff/src/respositories/dataProviders/dailyDishesProvider.dart';
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

  Future<void> fetchDailyDishes() async {
    _dailyDish = await _dailyDishProvider.getAll();
    print(_dailyDish);
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

  Future<DiscountCodeModel> addDiscountCode(String discountValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    DiscountCodeModel discount = await _billProvider.validDiscountCode(token, discountValue);
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
  Future<BillModel> createBill(List<CartDishModel> cartDishes, int tableNumber, {String discountCode, String voucherCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    List<int> dishIds = List<int>();
    List<String> dishNotes = List<String>();
    List<int> dishQuantities = List<int>();

    cartDishes.forEach((dish) {
      dishIds.add(dish.dishId);
      dishNotes.add(dish.note ?? "");
      dishQuantities.add(dish.quantity);
    });

    return await _billProvider.createBill(_currentUser.stores[0].id,token, tableNumber, dishIds, dishNotes, dishQuantities, "Khong bo hanh");
  }

  Future<List<BillModel>> getAllBill() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
    return await _billProvider.getAll(token);
  }

  Future<List<BillModel>> updateDiscountCode(String discountCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(EnvVariables.PrepsTokenKey);
  }
}
