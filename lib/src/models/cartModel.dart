import 'cartDishModel.dart';

class CartModel {
  List<CartDishModel> _listDishes;

  List<CartDishModel> get listDishes => _listDishes;

  CartModel.fromJson(List<dynamic> parseJson) {
    _listDishes = [];
    for (int i = 0; i < parseJson.length; i++) {
      var dish = CartDishModel.fromJson(parseJson[i]);
      _listDishes.add(dish);
    }
  }

  CartModel.empty() {
    _listDishes = [];
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> result = [];
    for (int i = 0; i < _listDishes.length; i++) {
      result.add(_listDishes[i].toJson());
    }
    return result;
  }
}
