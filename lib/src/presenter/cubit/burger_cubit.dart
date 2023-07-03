import 'package:atomic_state/src/presenter/states/burger_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../domain/entities/burger_entity.dart';
import '../../domain/repositories/burger_repository.dart';

class BurgerCubit extends Cubit<BurgerState> {
  final BurgerRepository repository;

  BurgerCubit(this.repository) : super(BurgerState.start());

  void fetchBurgersEvent() async {
    emit(state.setLoading());

    final newState = await repository
        .fetchBurgers() //
        .fold(state.setBurgers, state.setError);

    emit(newState);
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
