import 'package:equatable/equatable.dart';
import 'package:resman_mobile_staff/src/models/billModel.dart';
import 'package:resman_mobile_staff/src/models/cartDishModel.dart';
import 'package:resman_mobile_staff/src/models/discountCodeModel.dart';

abstract class CartBlocState extends Equatable {
  CartBlocState([List props = const []]) : super();
}

class CartBlocInitialize extends CartBlocState {
  @override
  String toString() => 'CartBlocInitialize';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocFetching extends CartBlocState {
  @override
  String toString() => 'CartBlocFetching';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocAddedDish extends CartBlocState {
  final CartDishModel dish;

  CartBlocAddedDish(this.dish) : super([dish]);

  @override
  String toString() =>
      'CartBlocAddedDish (dishId: ${dish.dishId}, quantity: ${dish.quantity}, price: ${dish.price})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocAddedDiscount extends CartBlocState {
  final DiscountCodeModel discount;

  CartBlocAddedDiscount(this.discount) : super([discount]);

  @override
  String toString() =>
      'CartBlocAddedDiscount (discountCode: ${discount.code}, value: ${discount.discount})';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocAddingDiscount extends CartBlocState {

  @override
  String toString() =>
      'CartBlocAddingDiscount...)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocAddedDiscountFailure extends CartBlocState {
  final String error;

  CartBlocAddedDiscountFailure(this.error) : super([error]);

  @override
  String toString() => 'CartBlocAddedDiscountFailure (error: $error)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocRemovedDish extends CartBlocState {
  final int dishId;

  CartBlocRemovedDish(this.dishId) : super([dishId]);

  @override
  String toString() => 'CartBlocRemovedDish (dishId: $dishId)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocChangedDishQuantity extends CartBlocState {
  final int dishId;
  final int quantity;

  CartBlocChangedDishQuantity(this.dishId, this.quantity)
      : super([dishId, quantity]);

  @override
  String toString() =>
      'CartBlocChangedDishQuantity (dishId: $dishId, quantity: $quantity)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocSaving extends CartBlocState {
  @override
  String toString() => 'CartBlocSaving';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocSaved extends CartBlocState {
  @override
  String toString() => 'CartBlocSaved';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocFetched extends CartBlocState {
  @override
  String toString() => 'CartBlocFetched';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocFailure extends CartBlocState {
  final String error;

  CartBlocFailure(this.error) : super([error]);

  @override
  String toString() => 'CartBlocFailure {error: $error}';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocCreatingBill extends CartBlocState {
  @override
  String toString() => 'CartBlocCreatingBill';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocCreatedBill extends CartBlocState {
  final BillModel bill;

  CartBlocCreatedBill(this.bill) : super([bill]);

  @override
  String toString() => 'CartBlocCreatedBill (billId: $bill)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CartBlocCreateBillFailure extends CartBlocState {
  final String error;

  CartBlocCreateBillFailure(this.error) : super([error]);

  @override
  String toString() => 'CartBlocCreateBillFailure (error: $error)';

  @override
  // TODO: implement props
  List<Object> get props => null;
}
