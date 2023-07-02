import 'package:atomic_state/src/interactor/state/burger_state.dart';
import 'package:atomic_state/src/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/burger_model.dart';
import '../services/burger_service.dart';

mixin BurgerController on State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffoldState => scaffoldKey.currentState!;

  BurgerService get service => context.read();
  var state = BurgerState.start();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchBurgs();
    });
  }

  void _change(BurgerState newState) {
    if (newState == state) {
      return;
    }
    setState(() {
      state = newState;
    });
    _endDrawerListener();
  }

  void _endDrawerListener() {
    if (state.cartBurgers.isEmpty && scaffoldState.isEndDrawerOpen) {
      scaffoldState.closeEndDrawer();
    }
  }

  Future<void> fetchBurgs() async {
    _change(state.setLoading());
    final newState = await service.fetchBurgers(state);
    _change(newState);
  }

  void cleanCartBurger() async {
    _change(state.setCartBurgers(cartBurgers: []));
  }

  void addBurgerToCart(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.add(burger);
    _change(state.setCartBurgers(cartBurgers: cart));
  }

  void removeBurgerToCart(BurgerModel burger) async {
    final cart = state.cartBurgers.toList();
    cart.remove(burger);
    _change(state.setCartBurgers(cartBurgers: cart));
  }
}
