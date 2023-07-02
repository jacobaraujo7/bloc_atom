import 'package:flutter/material.dart';

import '../models/burger_model.dart';
import '../services/burger_service.dart';
import '../state/burger_state.dart';

class BurgerStore extends ValueNotifier<BurgerState> {
  final BurgerService service;

  BurgerStore(this.service) : super(BurgerState.start());

  Future<void> fetchBurgs() async {
    value = value.setLoading();
    value = await service.fetchBurgers(value);
  }

  void cleanCartBurger() async {
    value = value.setCartBurgers(cartBurgers: []);
  }

  void addBurgerToCart(BurgerModel burger) async {
    final cart = value.cartBurgers.toList();
    cart.add(burger);
    value = value.setCartBurgers(cartBurgers: cart);
  }

  void removeBurgerToCart(BurgerModel burger) async {
    final cart = value.cartBurgers.toList();
    cart.remove(burger);
    value = value.setCartBurgers(cartBurgers: cart);
  }
}
