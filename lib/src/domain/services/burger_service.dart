import '../states/burger_state.dart';

abstract interface class BurgerService {
  Future<BurgerState> fetchBurgers();
}
