import 'package:atomic_state/src/interactor/states/burger_state.dart';

abstract interface class BurgerService {
  Future<BurgerState> fetchBurgers(BurgerState state);
}
