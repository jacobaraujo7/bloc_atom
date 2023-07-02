import 'package:atomic_state/src/interactor/controllers/burger_controller.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BurgerController>()
        ..fetchBurgs()
        ..addListener(_endDrawerListener);
    });
  }

  void _endDrawerListener() {
    final controller = context.read<BurgerController>();
    if (controller.state.cartBurgers.isEmpty && scaffoldState.isEndDrawerOpen) {
      scaffoldState.closeEndDrawer();
    }
  }

  @override
  void dispose() {
    context.read<BurgerController>().removeListener(_endDrawerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<BurgerController>();
    final state = controller.state;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: state.cartBurgers,
        onFinalize: controller.cleanCartBurger,
        onRemove: controller.removeBurgerToCart,
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
                  controller.addBurgerToCart(model);
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
