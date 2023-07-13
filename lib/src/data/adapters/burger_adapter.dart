import 'package:dson_adapter/dson_adapter.dart';

import '../../interactor/entities/burger_entity.dart';

class BurgerAdapter {
  BurgerAdapter._();

  static BurgerEntity fromMap(dynamic map) {
    const dson = DSON();
    return dson.fromJson<BurgerEntity>(map, BurgerEntity.new);
  }
}
