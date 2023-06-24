import 'package:asp/asp.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../../domain/atom/burger_atom.dart';
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

  late final RxDisposer _endDrawerListener;

  @override
  void initState() {
    super.initState();
    fetchBurgsAction();
    _endDrawerListener = rxObserver(
      () => cartBurgsState.value,
      filter: () => cartBurgsState.value.isEmpty,
      effect: (value) => scaffoldState.closeEndDrawer(),
    );
  }

  @override
  void dispose() {
    _endDrawerListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (burgers, isLoading, cartBurgers) = context.select(
      () => (burgersState.value, burgerLoadingState.value, cartBurgsState.value),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: cartBurgers,
        onFinalize: cleanCartAction,
        onRemove: removeBurgAction.setValue,
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: burgers.length,
            itemBuilder: (context, index) {
              final model = burgers[index];
              return BurgerCard(
                model: model,
                onTap: () {
                  addBurgerToCartAction.setValue(model);
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
          if (cartBurgers.isNotEmpty) {
            scaffoldState.openEndDrawer();
          }
        },
        child: badges.Badge(
          badgeContent: Text('${cartBurgsState.value.length}'),
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
    );
  }
}
