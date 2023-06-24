import 'package:asp/asp.dart';
import 'package:atomic_state/src/data/exceptions/burger_exception.dart';
import 'package:atomic_state/src/domain/models/burger_model.dart';

// atoms
final burgersState = Atom<List<BurgerModel>>([]);
final burgerLoadingState = Atom(true);
final burgerErrorState = Atom<BurgerException?>(null);
final cartBurgsState = Atom<List<BurgerModel>>([]);

// actions
final fetchBurgsAction = Atom.action();
final addBurgerToCartAction = Atom<BurgerModel?>(null);
final removeBurgAction = Atom<BurgerModel?>(null);
final cleanCartAction = Atom.action();
