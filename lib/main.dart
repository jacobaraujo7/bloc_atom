import 'package:atomic_state/src/interactor/stores/burger_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

import 'src/app_widget.dart';
import 'src/data/services/burger_service.dart';
import 'src/interactor/services/burger_service.dart';

void main() {
  final app = MultiProvider(
    providers: [
      Provider.value(value: Uno()),
      Provider<BurgerService>(create: (ctx) => BurgerServiceImpl(ctx.read())),
      Provider(create: (ctx) => BurgerStore(ctx.read())),
    ],
    child: const AppWidget(),
  );

  runApp(app);
}
