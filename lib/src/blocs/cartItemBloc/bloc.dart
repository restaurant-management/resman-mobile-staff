import 'package:bloc/bloc.dart';
import 'package:resman_mobile_staff/src/blocs/cartItemBloc/state.dart';
import 'package:resman_mobile_staff/src/respositories/responsitory.dart';

import 'event.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final Repository _repository = Repository();

  @override
  CartItemState get initialState => CartItemInitialize();

  @override
  Stream<CartItemState> mapEventToState(CartItemEvent event) async* {
    if (event is FetchCartItemDetail) {
      var dishesToday = _repository.dailyDish;
      var result = dishesToday.firstWhere(
              (dish) => dish.dish.dishId == event.cartDish.dishId,
          orElse: () => null);
      if (result == null) {
        yield CartItemToFetchDetailNotSellToDay(event.cartDish);
      } else {
        yield CartItemFetchedCartDishDetail(result);
      }
    }
  }

}