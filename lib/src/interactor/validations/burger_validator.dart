import 'package:atomic_state/src/interactor/entities/burger_entity.dart';

extension BurgerValidator on BurgerEntity {
  String? idValidate() {
    if (id.isEmpty) {
      return 'ID não pode ser null';
    }

    return null;
  }

  String? titleValidate() {
    if (title.isEmpty) {
      return 'title não pode ser null';
    }

    return null;
  }

  String? validate() {
    return idValidate() ?? titleValidate();
  }
}
