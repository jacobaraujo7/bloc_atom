import 'package:dson_adapter/dson_adapter.dart';
import 'package:uno/uno.dart';

import '../../interactor/exceptions/burger_exception.dart';
import '../../interactor/services/burger_service.dart';
import '../../interactor/states/burger_state.dart';
import '../adapters/burger_adapter.dart';

class BurgerServiceImpl implements BurgerService {
  final Uno uno;

  BurgerServiceImpl(this.uno);

  @override
  Future<BurgerState> fetchBurgers() async {
    try {
      final response = await uno.get(
        'https://raw.githubusercontent.com/jacobaraujo7/bloc_atom/asp/server/db.json',
        responseType: ResponseType.json,
      );
      final list = response.data['products'] as List;
      final burgers = list.map(BurgerAdapter.fromMap).toList();
      return GettedBurgerState(burgers: burgers, cartBurgers: []);
    } on UnoError catch (e, s) {
      final exception = BurgerServiceException(e.message, s);
      throw exception;
    } on DSONException catch (e, s) {
      final exception = BurgerServiceException(e.message, s);
      throw exception;
    }
  }
}
