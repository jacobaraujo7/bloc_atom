import 'package:atomic_state/src/interactor/state/burger_state.dart';
import 'package:dson_adapter/dson_adapter.dart';
import 'package:uno/uno.dart';

import '../../interactor/exceptions/burger_exception.dart';
import '../../interactor/services/burger_service.dart';
import '../adapters/burger_adapter.dart';

class BurgerServiceImpl implements BurgerService {
  final Uno uno;

  BurgerServiceImpl(this.uno);

  @override
  Future<BurgerState> fetchBurgers(BurgerState state) async {
    try {
      final response = await uno.get('http://localhost:3031/products');
      final list = response.data as List;
      final burgers = list.map(BurgerAdapter.fromMap).toList();
      return state.setBurgers(burgers);
    } on UnoError catch (e, s) {
      return state.setError(BurgerServiceException(e.message, s));
    } on DSONException catch (e, s) {
      return state.setError(BurgerServiceException(e.message, s));
    }
  }
}
