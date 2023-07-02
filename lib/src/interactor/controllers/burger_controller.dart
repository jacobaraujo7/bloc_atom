import 'package:atomic_state/src/interactor/atom/burger_atom.dart';
import 'package:atomic_state/src/interactor/state/burger_state.dart';
import 'package:flutter/material.dart';

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

  void addBurger() {
    final burg = addBurgerToCartAction.value;
    if (burg != null) {
      cartBurgsState.value.add(burg);
      cartBurgsState();
    }
  }

  void removeBurger() {
    final burg = removeBurgAction.value;
    if (burg != null) {
      cartBurgsState.value.remove(burg);
      cartBurgsState();
    }
  }

  cleanCart() {
    cartBurgsState.value.clear();
    cartBurgsState();
  }
}
