import 'package:atomic_state/src/interactor/states/burger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entities/burger_entity.dart';
import '../services/burger_service.dart';

class BurgerCubit extends Cubit<BurgerState> {
  final BurgerService service;

  BurgerCubit(this.service) : super(BurgerState.start());

  void fetchBurgersEvent() async {
    emit(state.setLoading());

    await service
        .fetchBurgers(state) //
        .then(emit);
  }

  void cleanCartBurgerEvent() async {
    emit(state.setCartBurgers(cartBurgers: []));
  }

  void addBurgerToCartEvent(BurgerEntity burger) async {
    final cart = state.cartBurgers.toList();
    cart.add(burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    emit(newState);
  }

  void removeBurgerToCartEvent(BurgerEntity burger) async {
    final cart = state.cartBurgers.toList();
    cart.remove(burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    emit(newState);
  }

  void dispose() {
    close();
  }
}
