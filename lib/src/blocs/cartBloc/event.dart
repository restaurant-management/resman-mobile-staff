import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/dailyDishModel.dart';

abstract class CartBlocEvent extends Equatable {
  CartBlocEvent([List props = const []]) : super();
}

class FetchCartBloc extends CartBlocEvent {
  @override
  String toString() => 'FetchCartBloc';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SaveCartBloc extends CartBlocEvent {
  @override
  String toString() => 'SaveCartBloc';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AddDishIntoCart extends CartBlocEvent {
  final DailyDishModel dish;

  AddDishIntoCart(this.dish) : super([dish]);

  @override
  String toString() => 'AddDishIntoCart {id: ${dish.dish.dishId}';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RemoveDishFromCart extends CartBlocEvent {
  final int dishId;

  RemoveDishFromCart(this.dishId) : super([dishId]);

  @override
  String toString() => 'RemoveDishFromCart (dishId: $dishId})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class ChangeDistQuantityInCart extends CartBlocEvent {
  final int dishId;
  final int quantity;

  ChangeDistQuantityInCart(this.dishId, this.quantity)
      : super([dishId, quantity]);

  @override
  String toString() =>
      'ChangeDistQuantityInCart (dishid: $dishId, quantity: $quantity)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class AddDiscountCode extends CartBlocEvent {
  final String discountCode;

  AddDiscountCode(this.discountCode);

  @override
  String toString() => 'CreateBillFromCart';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CreateBillFromCart extends CartBlocEvent {
  final int tableNumber;
  final String discountCode;
  final String voucherCode;
  final String customerUuid;

  CreateBillFromCart(this.tableNumber, {this.customerUuid, this.voucherCode, this.discountCode});

  @override
  String toString() => 'CreateBillFromCart';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
