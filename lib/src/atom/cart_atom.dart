// atom
import 'package:asp/asp.dart';

import '../models/burger_model.dart';

// atom
final cartBurgsState = Atom<List<BurgerModel>>([]);

// action
final addBurgerToCartAction = Atom<BurgerModel?>(null);
final removeBurgAction = Atom<BurgerModel?>(null);
final cleanCartAction = Atom.action();
