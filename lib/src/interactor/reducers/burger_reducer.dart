import 'package:asp/asp.dart';
import 'package:atomic_state/src/interactor/atom/burger_atom.dart';

import '../services/burger_service.dart';

class BurgerReducer extends Reducer {
  final BurgerService service;

  BurgerReducer(this.service) {
    on(() => [fetchBurgsAction], _fetchBurgs);
    on(() => [addBurgerToCartAction], _addBurger);
    on(() => [removeBurgerAction], _removeBurger);
    on(() => [cleanCartAction], _cleanCart);
  }

  _fetchBurgs() async {
    burgerState.value = burgerState.value.setLoading();

    await service
        .fetchBurgers(burgerState.value) //
        .then(burgerState.setValue)
        .onError((error, stackTrace) => burgerState.value.setError);
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
    final burger = removeBurgerAction.value;
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
