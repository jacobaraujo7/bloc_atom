import 'package:atomic_state/src/infra/datasources/burger_datasource.dart';
import 'package:uno/uno.dart';

class UnoBurgerDatasource implements BurgerDatasource {
  final Uno uno;

  UnoBurgerDatasource(this.uno);

  @override
  Future<List> fetchBurgers() async {
    final response = await uno.get(
      'https://raw.githubusercontent.com/jacobaraujo7/bloc_atom/asp/server/db.json',
      responseType: ResponseType.json,
    );
    return response.data['products'] as List;
  }
}
