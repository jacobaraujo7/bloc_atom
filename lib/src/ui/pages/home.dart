import 'dart:async';

import 'package:atomic_state/src/domain/cubit/burger_cubit.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/burger_card.dart';
import '../widgets/cart_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldState get scaffoldState => scaffoldKey.currentState!;

  late final StreamSubscription _endDrawerListener;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<BurgerCubit>();
    cubit.fetchBurgersEvent();

    _endDrawerListener = cubit.stream //
        .where((state) => state.cartBurgers.isEmpty && scaffoldState.isEndDrawerOpen)
        .listen((event) {
      scaffoldState.closeEndDrawer();
    });
  }

  @override
  void dispose() {
    _endDrawerListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BurgerCubit>();
    final state = cubit.state;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: state.cartBurgers,
        onFinalize: cubit.cleanCartBurgerEvent,
        onRemove: cubit.removeBurgerToCartEvent,
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: state.burgers.length,
            itemBuilder: (context, index) {
              final model = state.burgers[index];
              return BurgerCard(
                model: model,
                onTap: () {
                  cubit.addBurgerToCartEvent(model);
                },
              );
            },
          ),
          if (state.loading)
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (state.cartBurgers.isNotEmpty) {
            scaffoldState.openEndDrawer();
          }
        },
        child: badges.Badge(
          badgeContent: Text('${state.cartBurgers.length}'),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
    );
  }
}
