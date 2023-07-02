import 'package:atomic_state/src/interactor/state/burger_state.dart';

abstract interface class BurgerService {
  Future<BurgerState> fetchBurgers(BurgerState state);
}
