import 'package:atomic_state/src/domain/cubit/burger_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

import 'src/app_widget.dart';
import 'src/data/services/burger_service.dart';
import 'src/domain/services/burger_service.dart';

void main() {
  final app = MultiProvider(
    providers: [
      Provider.value(value: Uno()),
      Provider<BurgerService>(create: (ctx) => BurgerServiceImpl(ctx.read())),
      // CUBIT
      BlocProvider(create: (ctx) => BurgerCubit(ctx.read())),
    ],
    child: const AppWidget(),
  );

  runApp(app);
}
