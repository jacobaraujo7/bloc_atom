import 'package:atomic_state/src/interactor/entities/burger_entity.dart';
import 'package:atomic_state/src/interactor/validations/burger_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('burger validator ...', () {
    var burger = BurgerEntity(
      id: '',
      image: '',
      price: 10.0,
      title: '',
    );

    expect(burger.validate(), 'ID não pode ser null');

    burger = burger.copyWith(id: 'jguhsfgkhsf');

    expect(burger.validate(), 'title não pode ser null');
  });
}
