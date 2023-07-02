import 'package:mobx/mobx.dart';

import '../models/burger_model.dart';
import '../services/burger_service.dart';
import '../state/burger_state.dart';

part 'burger_store.g.dart';

class BurgerStore = _BurgerStoreBase with _$BurgerStore;

abstract class _BurgerStoreBase with Store {
  final BurgerService service;

  @observable
  BurgerState state = BurgerState.start();

  _BurgerStoreBase(this.service);

  @action
  Future<void> fetchBurgs() async {
    state = state.setLoading();

    state = await service.fetchBurgers(state);
  }

  @action
  void cleanCartBurger() {
    state = state.setCartBurgers(cartBurgers: []);
  }

  @action
  void addBurgerToCart(BurgerModel burger) {
    final cart = state.cartBurgers.toList();
    cart.add(burger);
    state = state.setCartBurgers(cartBurgers: cart);
  }

  @action
  void removeBurgerToCart(BurgerModel burger) {
    final cart = state.cartBurgers.toList();
    cart.remove(burger);
    state = state.setCartBurgers(cartBurgers: cart);
  }
}
