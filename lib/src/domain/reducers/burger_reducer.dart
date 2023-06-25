import 'package:asp/asp.dart';
import 'package:atomic_state/src/domain/atom/burger_atom.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/services/burger_service.dart';

class BurgerReducer extends Reducer {
  final BurgerService service;

  BurgerReducer(this.service) {
    on(() => [fetchBurgsAction], _fetchBurgs);
    on(() => [addBurgerToCartAction], _addBurger);
    on(() => [removeBurgAction], _removeBurger);
    on(() => [cleanCartAction], _cleanCart);
  }

  _fetchBurgs() async {
    burgerState.value = burgerState.value.setLoading();

    final newState = await service
        .fetchBurgers() //
        .fold(
          burgerState.value.setBurgers,
          burgerState.value.setError,
        );

    burgerState.value = newState;
  }

  _addBurger() {
    final burger = addBurgerToCartAction.value;
    if (burger != null) {
      final cart = burgerState.value.cartBurgers.toList();
      cart.add(burger);
      final newState = burgerState.value.setCartBurgers(cartBurgers: cart);
      burgerState.value = newState;
    }
  }

  _removeBurger() {
    final burger = addBurgerToCartAction.value;
    if (burger != null) {
      final cart = burgerState.value.cartBurgers.toList();
      cart.remove(burger);
      final newState = burgerState.value.setCartBurgers(cartBurgers: cart);
      burgerState.value = newState;
    }
  }

  _cleanCart() {
    burgerState.value = burgerState.value.setCartBurgers(cartBurgers: []);
  }
}
