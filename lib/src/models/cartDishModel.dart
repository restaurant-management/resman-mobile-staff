import 'dailyDishModel.dart';

class CartDishModel {
  int _dishId;
  int _quantity;
  String _price;

  int get dishId => _dishId;

  int get quantity => _quantity;

  set quantity(int q) {
    _quantity = q < 1 ? 1 : q;
  }

  String get price => _price;

  CartDishModel.fromJson(Map<String, dynamic> parseJson) {
    _dishId = parseJson['dishId'];
    _quantity = parseJson['quantity'];
    _price = parseJson['price'];
  }

  CartDishModel.fromDailyDish(DailyDishModel dailyDish, {int quantity = 1}) {
    _dishId = dailyDish.dish.dishId;
    _quantity = quantity;
    _price = dailyDish.dish.defaultPrice;
  }

  Map<String, dynamic> toJson() => {
        'dishId': _dishId,
        'quantity': _quantity,
        'price': _price,
      };
}
