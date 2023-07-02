import 'package:atomic_state/src/interactor/models/burger_model.dart';
import 'package:dson_adapter/dson_adapter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:uno/uno.dart';

import '../../interactor/exceptions/burger_exception.dart';
import '../../interactor/services/burger_service.dart';
import '../adapters/burger_adapter.dart';

class BurgerServiceImpl implements BurgerService {
  final Uno uno;

  BurgerServiceImpl(this.uno);

  @override
  AsyncResult<List<BurgerModel>, BurgerException> fetchBurgers() async {
    try {
      final response = await uno.get('http://localhost:3031/products');
      final list = response.data as List;
      final burgers = list.map(BurgerAdapter.fromMap).toList();
      return Result.success(burgers);
    } on UnoError catch (e, s) {
      return Result.failure(BurgerServiceException(e.message, s));
    } on DSONException catch (e, s) {
      return Result.failure(BurgerServiceException(e.message, s));
    }
  }
}
