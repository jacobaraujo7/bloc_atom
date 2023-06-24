import 'package:asp/asp.dart';
import 'package:atomic_state/src/data/exceptions/burger_exception.dart';
import 'package:atomic_state/src/domain/models/burger_model.dart';

// atoms
final burgersState = Atom<List<BurgerModel>>([]);
final burgerLoadingState = Atom(true);
final burgerErrorState = Atom<BurgerException?>(null);

// actions
final fetchBurgsAction = Atom.action();
