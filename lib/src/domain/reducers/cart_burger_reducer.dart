import 'package:asp/asp.dart';
import 'package:atomic_state/src/domain/atom/cart_atom.dart';

class CartBurgerReducer extends Reducer {
  CartBurgerReducer() {
    on(() => [addBurgerToCartAction], _addBurger);
    on(() => [removeBurgAction], _removeBurger);
    on(() => [cleanCartAction], _cleanCart);
  }

  _addBurger() {
    final burg = addBurgerToCartAction.value;
    if (burg != null) {
      cartBurgsState.value.add(burg);
      cartBurgsState();
    }
  }

  _removeBurger() {
    final burg = removeBurgAction.value;
    if (burg != null) {
      cartBurgsState.value.remove(burg);
      cartBurgsState();
    }
  }

  _cleanCart() {
    cartBurgsState.value.clear();
    cartBurgsState();
  }
}
