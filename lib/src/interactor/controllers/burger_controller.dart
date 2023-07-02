import 'package:atomic_state/src/interactor/atom/burger_atom.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';

import '../services/burger_service.dart';

class BurgerController extends ChangeNotifier {
  final BurgerService service;

  BurgerController(this.service);

  Future<void> fetchBurgs() async {
    burgerLoadingState.value = true;

    await service
        .fetchBurgers() //
        .fold(
          burgersState.setValue,
          burgerErrorState.setValue,
        );

    burgerLoadingState.value = false;
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
