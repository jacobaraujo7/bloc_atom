import 'package:atomic_state/src/domain/entities/burger_entity.dart';
import 'package:atomic_state/src/domain/exceptions/burger_exception.dart';

sealed class BurgerState {
  final List<BurgerEntity> burgers;
  final List<BurgerEntity> cartBurgers;
  final bool loading;
  final BurgerException? exception;

  const BurgerState({
    required this.burgers,
    required this.cartBurgers,
    this.loading = false,
    this.exception,
  });

  factory BurgerState.start() => const StartBurgerState();

  BurgerState setBurgers(
    List<BurgerEntity> burgers,
  ) {
    return GettedBurgerState(
      burgers: burgers,
      cartBurgers: cartBurgers,
    );
  }

  BurgerState setCartBurgers({
    List<BurgerEntity>? burgers,
    List<BurgerEntity>? cartBurgers,
  }) {
    return GettedBurgerState(
      burgers: burgers ?? this.burgers,
      cartBurgers: cartBurgers ?? this.cartBurgers,
    );
  }

  BurgerState setLoading() {
    return LoadingBurgerState(burgers: burgers, cartBurgers: cartBurgers);
  }

  BurgerState setError(BurgerException exception) {
    return ErrorBurgerState(
      exception: exception,
      burgers: burgers,
      cartBurgers: cartBurgers,
    );
  }
}

class StartBurgerState extends BurgerState {
  const StartBurgerState() : super(burgers: const [], cartBurgers: const []);
}

class GettedBurgerState extends BurgerState {
  const GettedBurgerState({
    required super.burgers,
    required super.cartBurgers,
  });
}

class LoadingBurgerState extends BurgerState {
  const LoadingBurgerState({
    required super.burgers,
    required super.cartBurgers,
  }) : super(loading: true);
}

class ErrorBurgerState extends BurgerState {
  const ErrorBurgerState({
    required super.exception,
    required super.burgers,
    required super.cartBurgers,
  }) : super(loading: true);
}
