import 'dart:async';

import 'package:atomic_state/src/domain/states/burger_state.dart';

abstract interface class BurgerService {
  Future<BurgerState> fetchBurgers(BurgerState state);
}
