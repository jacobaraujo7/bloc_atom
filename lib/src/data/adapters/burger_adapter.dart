import 'package:dson_adapter/dson_adapter.dart';

import '../../interactor/models/burger_model.dart';

class BurgerAdapter {
  BurgerAdapter._();

  static BurgerModel fromMap(dynamic map) {
    const dson = DSON();
    return dson.fromJson<BurgerModel>(map, BurgerModel.new);
  }
}
