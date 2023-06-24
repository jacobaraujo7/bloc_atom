import 'package:asp/asp.dart';
import 'package:atomic_state/src/domain/reducers/burger_reducer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

import 'src/app_widget.dart';
import 'src/data/services/burger_service.dart';
import 'src/domain/reducers/cart_burger_reducer.dart';

void main() {
  final app = MultiProvider(
    providers: [
      Provider.value(value: Uno()),
      Provider<BurgerService>(create: (ctx) => BurgerServiceImpl(ctx.read())),
      // ASP
      Provider(create: (ctx) => BurgerReducer(ctx.read())),
      Provider(create: (ctx) => CartBurgerReducer()),
    ],
    builder: (context, child) {
      return RxRoot(
        reducers: [
          context.read<BurgerReducer>(),
          context.read<CartBurgerReducer>(),
        ],
        child: const AppWidget(),
      );
    },
  );

  runApp(app);
}
