import 'package:atomic_state/src/domain/entities/burger_entity.dart';
import 'package:atomic_state/src/domain/exceptions/burger_exception.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class BurgerRepository {
  AsyncResult<List<BurgerEntity>, BurgerException> fetchBurgers();
}
