import 'package:atomic_state/src/domain/usecases/fetch_burgers.dart';
import 'package:atomic_state/src/infra/datasources/burger_datasource.dart';
import 'package:atomic_state/src/presenter/cubit/burger_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

import 'src/app_widget.dart';
import 'src/domain/repositories/burger_repository.dart';
import 'src/external/uno_burger_datasource.dart';
import 'src/infra/repositories/burger_repository.dart';

void main() {
  final app = MultiProvider(
    providers: [
      Provider.value(value: Uno()),
      Provider<BurgerDatasource>(create: (ctx) => UnoBurgerDatasource(ctx.read())),
      Provider<BurgerRepository>(create: (ctx) => BurgerRepositoryImpl(ctx.read())),
      Provider<FetchBurgers>(create: (ctx) => FetchBurgersUsecase(ctx.read())),
      // CUBIT
      BlocProvider(create: (ctx) => BurgerCubit(ctx.read())),
    ],
    child: const AppWidget(),
  );

  runApp(app);
}
