import 'package:atomic_state/src/interactor/models/burger_model.dart';

sealed class BurgerState {
  final List<BurgerModel> burgers;
  final List<BurgerModel> cartBurgers;

  const BurgerState({
    required this.burgers,
    required this.cartBurgers,
  });

  factory BurgerState.start() => const StartBurgerState();

  BurgerState setBurgers(
    List<BurgerModel> burgers,
  ) {
    return GettedBurgerState(
      burgers: burgers,
      cartBurgers: cartBurgers,
    );
  }

  BurgerState setCartBurgers({
    List<BurgerModel>? burgers,
    List<BurgerModel>? cartBurgers,
  }) {
    return GettedBurgerState(
      burgers: burgers ?? this.burgers,
      cartBurgers: cartBurgers ?? this.cartBurgers,
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
