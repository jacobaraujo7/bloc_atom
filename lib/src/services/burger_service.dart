import 'package:atomic_state/src/models/burger_model.dart';
import 'package:uno/uno.dart';

class BurgerService {
  final Uno uno;

  BurgerService(this.uno);

  Future<List<BurgerModel>> fetchBurgs() async {
    final response = await uno.get('http://127.0.0.1:3031/products');
    final list = response.data as List;
    return list.map((e) => BurgerModel.fromMap(e)).toList();
  }
}
