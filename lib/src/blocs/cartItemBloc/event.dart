import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';

abstract class CartItemEvent extends Equatable {
  CartItemEvent([List props = const []]) : super();
}

class FetchCartItemDetail extends CartItemEvent {
  final CartDishModel cartDish;

  FetchCartItemDetail(this.cartDish) : super([cartDish]);

  @override
  String toString() => 'FetchCartItemDetail (dishId: ${cartDish.dishId})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
