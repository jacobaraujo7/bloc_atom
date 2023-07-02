import 'package:atomic_state/src/interactor/models/burger_model.dart';
import 'package:result_dart/result_dart.dart';

import '../exceptions/burger_exception.dart';

abstract interface class BurgerService {
  AsyncResult<List<BurgerModel>, BurgerException> fetchBurgers();
}
