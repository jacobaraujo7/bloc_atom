import 'package:atomic_state/src/domain/exceptions/burger_exception.dart';
import 'package:atomic_state/src/domain/repositories/burger_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../entities/burger_entity.dart';

abstract interface class FetchBurgers {
  AsyncResult<List<BurgerEntity>, BurgerException> call();
}

class FetchBurgersUsecase implements FetchBurgers {
  final BurgerRepository repository;

  FetchBurgersUsecase(this.repository);
  @override
  AsyncResult<List<BurgerEntity>, BurgerException> call() {
    return repository.fetchBurgers();
  }
}
