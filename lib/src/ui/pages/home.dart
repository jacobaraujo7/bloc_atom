import 'package:atomic_state/src/interactor/stores/burger_store.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
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

  late ReactionDisposer _endDrawerListener;

  @override
  void initState() {
    super.initState();
    final store = context.read<BurgerStore>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _endDrawerListener = reaction(
        (_) => store.state,
        (state) {
          if (state.cartBurgers.isEmpty && scaffoldState.isEndDrawerOpen) {
            scaffoldState.closeEndDrawer();
          }
        },
      );

      store.fetchBurgs();
    });
  }

  @override
  void dispose() {
    _endDrawerListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<BurgerStore>();

    return Observer(builder: (_) {
      final state = store.state;
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[Container()],
          title: const Text('Flutter Burge'),
          centerTitle: true,
        ),
        endDrawer: CartDrawer(
          burgers: state.cartBurgers,
          onFinalize: store.cleanCartBurger,
          onRemove: store.removeBurgerToCart,
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
                    store.addBurgerToCart(model);
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
    });
  }
}
