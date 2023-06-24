import 'package:atomic_state/src/data/services/burger_service.dart';
import 'package:atomic_state/src/domain/states/burger_state.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:result_dart/result_dart.dart';

import '../models/burger_model.dart';

class BurgerStore extends Store<BurgerState> {
  final BurgerService service;

  BurgerStore(this.service) : super(BurgerState.start());

  void fetchBurgersEvent() async {
    setLoading(true);

    await service
        .fetchBurgers() //
        .map(state.setBurgers)
        .fold(update, setError);
  }

  void cleanCartBurgerEvent() async {
    update(state.setCartBurgers(cartBurgers: []));
  }

  void addBurgerToCartEvent(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.add(burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    update(newState);
  }

  void removeBurgerToCartEvent(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.remove(burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    update(newState);
  }
}
