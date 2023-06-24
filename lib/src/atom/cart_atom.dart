// atom
import 'package:asp/asp.dart';

import '../models/burger_model.dart';

// atom
final cartBurgsState = Atom<List<BurgerModel>>([]);

// computed
String get totalValueComputed {
  if (cartBurgsState.value.isEmpty) {
    return r'R$ 0.00';
  }
  final value = cartBurgsState.value.fold(
    0.0,
    (previousValue, element) => previousValue + element.price,
  );
  return r'R$ ' + value.toStringAsFixed(2);
}

// action
final addBurgerToCartAction = Atom<BurgerModel?>(null);
final removeBurgAction = Atom<BurgerModel?>(null);
final cleanCartAction = Atom.action();
