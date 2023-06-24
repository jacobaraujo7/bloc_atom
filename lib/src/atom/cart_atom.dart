// atom
import 'package:asp/asp.dart';

import '../models/burger_model.dart';

// atom
final cartBurgs = RxList<BurgerModel>([]);
final finalValue = Atom<String>('R\$ 0.00');

// action
final removeBurg = Atom<BurgerModel?>(null);
final cleanCart = Atom.action();
