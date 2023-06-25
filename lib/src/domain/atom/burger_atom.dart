import 'package:asp/asp.dart';
import 'package:atomic_state/src/domain/models/burger_model.dart';

import '../states/burger_state.dart';

// atoms
final burgerState = Atom<BurgerState>(BurgerState.start());

// actions
final fetchBurgsAction = Atom.action();
final addBurgerToCartAction = Atom<BurgerModel?>(null);
final removeBurgAction = Atom<BurgerModel?>(null);
final cleanCartAction = Atom.action();
