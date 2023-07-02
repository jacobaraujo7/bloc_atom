import 'package:atomic_state/src/interactor/states/burger_state.dart';
import 'package:dson_adapter/dson_adapter.dart';
import 'package:uno/uno.dart';

import '../../interactor/services/burger_service.dart';
import '../adapters/burger_adapter.dart';
import '../exceptions/burger_exception.dart';

class BurgerServiceImpl implements BurgerService {
  final Uno uno;

  BurgerServiceImpl(this.uno);

  @override
  Future<BurgerState> fetchBurgers(BurgerState state) async {
    try {
      final response = await uno.get(
        'https://raw.githubusercontent.com/jacobaraujo7/bloc_atom/asp/server/db.json',
        responseType: ResponseType.json,
      );
      final list = response.data['products'] as List;
      final burgers = list.map(BurgerAdapter.fromMap).toList();
      return state.setBurgers(burgers);
    } on UnoError catch (e, s) {
      return state.setError(BurgerServiceException(e.message, s));
    } on DSONException catch (e, s) {
      return state.setError(BurgerServiceException(e.message, s));
    }
  }
}
