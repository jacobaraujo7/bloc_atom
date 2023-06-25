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
      () => burgerState.value,
      filter: () => burgerState.value.cartBurgers.isEmpty,
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
    final state = context.select(() => burgerState.value);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[Container()],
        title: const Text('Flutter Burge'),
        centerTitle: true,
      ),
      endDrawer: CartDrawer(
        burgers: state.cartBurgers,
        onFinalize: cleanCartAction,
        onRemove: removeBurgAction.setValue,
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
                  addBurgerToCartAction.setValue(model);
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
