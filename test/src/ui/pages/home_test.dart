import 'package:atomic_state/src/interactor/controllers/burger_controller.dart';
import 'package:atomic_state/src/interactor/models/burger_model.dart';
import 'package:atomic_state/src/interactor/services/burger_service.dart';
import 'package:atomic_state/src/interactor/state/burger_state.dart';
import 'package:atomic_state/src/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

class BurgerServiceMock extends Mock implements BurgerService {}

void main() {
  late BurgerService service;

  final successState = BurgerState.start().setBurgers([
    BurgerModel(
      id: 'id',
      title: 'title burger',
      image: 'https://classic.exame.com/wp-content/uploads/2020/05/mafe-studio-LV2p9Utbkbw-unsplash-1.jpg?quality=70&strip=info&w=1024',
      price: 10.1,
    ),
  ]);

  setUpAll(() {
    registerFallbackValue(BurgerState.start());
  });

  setUp(() {
    service = BurgerServiceMock();
  });

  testWidgets('List burges', (tester) async {
    when(() => service.fetchBurgers(any())).thenAnswer((_) async => successState);

    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(
          Provider<BurgerService>.value(
            value: service,
            child: const MaterialApp(home: HomePage()),
          ),
        );

        final controller = tester.state<BurgerController>(find.byType(HomePage));
        expect(controller.state, successState);
        await tester.pump();
        expect(find.text('title burger'), findsOneWidget);
      },
    );
  });
}
