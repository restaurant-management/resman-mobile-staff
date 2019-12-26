import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';

abstract class CartItemState extends Equatable {
  CartItemState([List props = const []]) : super();
}

class CartItemInitialize extends CartItemState {
  @override
  String toString() => 'CartItemInitialize';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartItemFetchedCartDishDetail extends CartItemState {
  final DailyDishModel dailyDish;

  CartItemFetchedCartDishDetail(this.dailyDish) : super([dailyDish]);

  @override
  String toString() =>
      'CartItemFetchedCartDishDetail (dishId: ${dailyDish.dish.dishId})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartItemToFetchDetailNotSellToDay extends CartItemState {
  final CartDishModel cartDish;

  CartItemToFetchDetailNotSellToDay(this.cartDish) : super([cartDish]);

  @override
  String toString() =>
      'CartItemToFetchDetailNotSellToDay (dishId: ${cartDish.dishId})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
