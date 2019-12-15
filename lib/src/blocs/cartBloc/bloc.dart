import 'package:bloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/state.dart';
import 'package:resman_mobile_staff/src/models/cartModel.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';
import 'package:resman_mobile_staff/src/blocs/cartBloc/event.dart';

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  final Repository _repository = Repository();

  static CartBloc _singleton;

  static CartBloc get instance {
    if (_singleton == null) {
      _singleton = CartBloc._internal();
      _singleton.dispatch(FetchCartBloc());
    }
    return _singleton;
  }

  factory CartBloc() {
    return instance;
  }

  CartBloc._internal();

  CartModel get currentCart => _repository.currentCart;

  @override
  CartBlocState get initialState => CartBlocInitialize();

  @override
  Stream<CartBlocState> mapEventToState(CartBlocEvent event) async* {
    if (event is FetchCartBloc) {
      yield CartBlocFetching();
      try {
        await _repository.getCart();
        yield CartBlocFetched();
      } catch (e) {
        yield CartBlocFailure(e.toString());
      }
    }

    if (event is SaveCartBloc) {
      yield CartBlocSaving();
      try {
        await _repository.saveCart();
        yield CartBlocSaved();
      } catch (e) {
        yield CartBlocFailure(e.toString());
      }
    }

    if (event is AddDishIntoCart) {
      yield CartBlocAddedDish(_repository.addDishIntoCart(event.dish));
      dispatch(SaveCartBloc());
    }

    if (event is RemoveDishFromCart) {
      _repository.removeDishFromCart(event.dishId);
      yield CartBlocRemovedDish(event.dishId);
      dispatch(SaveCartBloc());
    }

    if (event is ChangeDistQuantityInCart) {
      _repository.changeDistQuantityInCart(event.dishId, event.quantity);
      yield CartBlocChangedDishQuantity(event.dishId, event.quantity);
      dispatch(SaveCartBloc());
    }

    if (event is CreateBillFromCart) {
      yield CartBlocCreatingBill();
      try {
        if (currentCart.listDishes.length == 0)
          throw Exception('Chưa có món ăn!');
        var bill = await _repository.createBill(currentCart.listDishes, event.tableNumber);
        await _repository.clearCart();
        yield CartBlocCreatedBill(bill);
      } catch (e) {
        yield CartBlocCreateBillFailure(e.toString());
      }
    }
  }
}
