import 'package:atomic_state/src/interactor/events/burger_event.dart';
import 'package:atomic_state/src/interactor/states/burger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/burger_service.dart';

class BurgerBloc extends Bloc<BurgerEvent, BurgerState> {
  final BurgerService service;

  BurgerBloc(this.service) : super(BurgerState.start()) {
    on<FetchBurgersEvent>(_fetchBurgersEvent);
    on<CleanCartBurgerEvent>(_cleanCartBurgerEvent);
    on<AddBurgerToCartEvent>(_addBurgerToCartEvent);
    on<RemoveBurgerFromCartEvent>(_removeBurgerToCartEvent);
  }

  void _fetchBurgersEvent(event, emit) async {
    emit(state.setLoading());

    await service
        .fetchBurgers(state) //
        .then(emit);
  }

  void _cleanCartBurgerEvent(event, emit) async {
    emit(state.setCartBurgers(cartBurgers: []));
  }

  void _addBurgerToCartEvent(AddBurgerToCartEvent event, emit) async {
    final cart = state.cartBurgers.toList();
    cart.add(event.burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    emit(newState);
  }

  void _removeBurgerToCartEvent(RemoveBurgerFromCartEvent event, emit) async {
    final cart = state.cartBurgers.toList();
    cart.remove(event.burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    emit(newState);
  }
}
