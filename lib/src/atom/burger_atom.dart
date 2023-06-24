import 'package:asp/asp.dart';
import 'package:atomic_state/src/models/burger_model.dart';

// atoms
final burgers = RxList<BurgerModel>([]);
final burgLoading = Atom(true);

// actions
final fetchBurgs = Atom.action();
final addBurger = Atom<BurgerModel?>(null);
