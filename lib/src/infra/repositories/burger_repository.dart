import 'package:atomic_state/src/domain/entities/burger_entity.dart';
import 'package:atomic_state/src/infra/datasources/burger_datasource.dart';
import 'package:dson_adapter/dson_adapter.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/exceptions/burger_exception.dart';
import '../../domain/repositories/burger_repository.dart';
import '../adapters/burger_adapter.dart';

class BurgerRepositoryImpl implements BurgerRepository {
  final BurgerDatasource datasource;

  BurgerRepositoryImpl(this.datasource);

  @override
  AsyncResult<List<BurgerEntity>, BurgerException> fetchBurgers() async {
    try {
      final list = await datasource.fetchBurgers();
      final burgers = list.map(BurgerAdapter.fromMap).toList();
      return Result.success(burgers);
    } on DSONException catch (e, s) {
      final exception = BurgerServiceException(e.message, s);
      return Result.failure(exception);
    }
  }
}
