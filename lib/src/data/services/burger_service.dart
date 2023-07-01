import 'package:dson_adapter/dson_adapter.dart';
import 'package:uno/uno.dart';

import '../../domain/exceptions/burger_exception.dart';
import '../../domain/services/burger_service.dart';
import '../../domain/states/burger_state.dart';
import '../adapters/burger_adapter.dart';

class BurgerServiceImpl implements BurgerService {
  final Uno uno;

  BurgerServiceImpl(this.uno);

  @override
  Future<BurgerState> fetchBurgers() async {
    try {
      final response = await uno.get('http://localhost:3031/products');
      final list = response.data as List;
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
