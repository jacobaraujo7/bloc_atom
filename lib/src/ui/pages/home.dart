import 'dart:async';

import 'package:atomic_state/src/interactor/blocs/burger_bloc.dart';
import 'package:atomic_state/src/interactor/events/burger_event.dart';
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
    final bloc = context.read<BurgerBloc>();
    bloc.add(FetchBurgersEvent());

    _endDrawerListener = bloc.stream //
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
    final bloc = context.watch<BurgerBloc>();
    final state = bloc.state;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: state.cartBurgers,
        onFinalize: () {
          bloc.add(CleanCartBurgerEvent());
        },
        onRemove: (burger) {
          bloc.add(RemoveBurgerFromCartEvent(burger));
        },
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
                  bloc.add(AddBurgerToCartEvent(model));
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
