import 'package:atomic_state/src/interactor/state/burger_state.dart';
import 'package:flutter/material.dart';

import '../models/burger_model.dart';
import '../services/burger_service.dart';

class BurgerController extends ChangeNotifier {
  final BurgerService service;

  var _state = BurgerState.start();
  BurgerState get state => _state;

  BurgerController(this.service);

  Future<void> fetchBurgs() async {
    _state = state.setLoading();
    notifyListeners();

    _state = await service.fetchBurgers(state);
    notifyListeners();
  }

  void cleanCartBurger() async {
    _state = state.setCartBurgers(cartBurgers: []);
    notifyListeners();
  }

  void addBurgerToCart(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.add(burger);
    _state = state.setCartBurgers(cartBurgers: cart);
    notifyListeners();
  }

  void removeBurgerToCart(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.remove(burger);
    _state = state.setCartBurgers(cartBurgers: cart);
    notifyListeners();
  }
}
