import 'package:asp/asp.dart';
import 'package:atomic_state/src/atom/burger_atom.dart';
import 'package:atomic_state/src/atom/cart_atom.dart';

import '../services/burger_service.dart';

class BurgerReducer extends Reducer {
  final BurgerService service;

  BurgerReducer(this.service) {
    on(() => [fetchBurgs], _fetchBurgs);
    on(() => [addBurger], _addBurg);
    on(() => [removeBurg], _removeBurg);
    on(() => [cleanCart], _cleanCart);
    on(() => [cartBurgs.length], _changeFinalValue);
  }

  _changeFinalValue() {
    final value = cartBurgs.fold(0.0, (previousValue, element) => previousValue + element.price);
    finalValue.value = r'R$ ' + value.toStringAsFixed(2);
  }

  _fetchBurgs() async {
    burgLoading.value = true;

    final result = await service.fetchBurgs();
    burgers.clear();
    burgers.addAll(result);

    burgLoading.value = false;
  }

  _addBurg() {
    final burg = addBurger.value;
    if (burg != null) {
      cartBurgs.add(burg);
    }
  }

  _removeBurg() {
    final burg = removeBurg.value;
    if (burg != null) {
      cartBurgs.remove(burg);
    }
  }

  _cleanCart() => cartBurgs.clear();
}
