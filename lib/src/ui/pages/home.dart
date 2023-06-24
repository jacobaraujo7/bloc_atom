import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:provider/provider.dart' hide SelectContext;

import '../../domain/store/burger_store.dart';
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

  late final Disposer _endDrawerListener;

  @override
  void initState() {
    super.initState();
    final store = context.read<BurgerStore>();
    store.fetchBurgersEvent();

    _endDrawerListener = store.observer(
      onState: (state) {
        if (state.cartBurgers.isEmpty && scaffoldState.isEndDrawerOpen) {
          scaffoldState.closeEndDrawer();
        }
      },
    );
  }

  @override
  void dispose() {
    _endDrawerListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.read<BurgerStore>();
    final (state, isLoading) = context.select(
      () => (store.state, store.isLoading),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: state.cartBurgers,
        onFinalize: store.cleanCartBurgerEvent,
        onRemove: store.removeBurgerToCartEvent,
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
                  store.addBurgerToCartEvent(model);
                },
              );
            },
          ),
          if (isLoading)
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
