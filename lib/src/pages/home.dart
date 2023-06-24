import 'package:asp/asp.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../atom/burger_atom.dart';
import '../atom/cart_atom.dart';
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
    context.select(() => [burgersState, burgerLoadingState, cartBurgsState]);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: cartBurgsState.value,
        onFinalize: cleanCartAction,
        onRemove: removeBurgAction.setValue,
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: burgersState.value.length,
            itemBuilder: (context, index) {
              final model = burgersState.value[index];
              return BurgerCard(
                model: model,
                onTap: () {
                  addBurgerToCartAction.setValue(model);
                },
              );
            },
          ),
          if (burgerLoadingState.value)
            const Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cartBurgsState.value.isNotEmpty) {
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
