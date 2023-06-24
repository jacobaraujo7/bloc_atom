import 'package:atomic_state/src/data/services/burger_service.dart';
import 'package:atomic_state/src/domain/states/burger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../models/burger_model.dart';

class BurgerCubit extends Cubit<BurgerState> {
  final BurgerService service;

  BurgerCubit(this.service) : super(BurgerState.start());

  void fetchBurgersEvent() async {
    emit(state.setLoading());

    final newState = await service
        .fetchBurgers() //
        .fold(state.setBurgers, state.setError);

    emit(newState);
  }

  void cleanCartBurgerEvent() async {
    emit(state.setCartBurgers(cartBurgers: []));
  }

  void addBurgerToCartEvent(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.add(burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    emit(newState);
  }

  void removeBurgerToCartEvent(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.remove(burger);
    final newState = state.setCartBurgers(cartBurgers: cart);
    emit(newState);
  }
}
