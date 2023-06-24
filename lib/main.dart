import 'package:asp/asp.dart';
import 'package:atomic_state/src/reducers/burger_reducer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

import 'src/pages/home.dart';
import 'src/reducers/cart_burger_reducer.dart';
import 'src/services/burger_service.dart';

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
        child: const MyApp(),
      );
    },
  );

  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        brightness: Brightness.dark,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
