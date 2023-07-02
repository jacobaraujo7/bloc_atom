import 'package:atomic_state/src/interactor/models/burger_model.dart';

sealed class BurgerEvent {}

class FetchBurgersEvent implements BurgerEvent {}

class CleanCartBurgerEvent implements BurgerEvent {}

class AddBurgerToCartEvent implements BurgerEvent {
  final BurgerModel burger;

  const AddBurgerToCartEvent(this.burger);
}

class RemoveBurgerFromCartEvent implements BurgerEvent {
  final BurgerModel burger;

  const RemoveBurgerFromCartEvent(this.burger);
}
