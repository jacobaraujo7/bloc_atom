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
    burgerLoadingState.value = true;

    await service
        .fetchBurgers() //
        .fold(
          burgersState.setValue,
          burgerErrorState.setValue,
        );

    burgerLoadingState.value = false;
  }

  _addBurger() {
    final burg = addBurgerToCartAction.value;
    if (burg != null) {
      cartBurgsState.value.add(burg);
      cartBurgsState();
    }
  }

  _removeBurger() {
    final burg = removeBurgAction.value;
    if (burg != null) {
      cartBurgsState.value.remove(burg);
      cartBurgsState();
    }
  }

  _cleanCart() {
    cartBurgsState.value.clear();
    cartBurgsState();
  }
}
