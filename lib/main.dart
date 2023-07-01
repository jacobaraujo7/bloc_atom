import 'package:atomic_state/src/domain/services/burger_service.dart';
import 'package:atomic_state/src/domain/store/burger_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

import 'src/app_widget.dart';
import 'src/data/services/burger_service.dart';

void main() {
  final app = MultiProvider(
    providers: [
      Provider.value(value: Uno()),
      Provider<BurgerService>(create: (ctx) => BurgerServiceImpl(ctx.read())),
      // CUBIT
      Provider(create: (ctx) => BurgerStore(ctx.read())),
    ],
    child: const RxRoot(child: AppWidget()),
  );

  runApp(app);
}
