import 'package:atomic_state/src/interactor/models/burger_model.dart';
import 'package:flutter/material.dart';

class CartDrawer extends StatelessWidget {
  final List<BurgerModel> burgers;
  final void Function()? onFinalize;
  final void Function(BurgerModel burger)? onRemove;

  const CartDrawer({super.key, required this.burgers, this.onFinalize, this.onRemove});

  String get totalValue {
    if (burgers.isEmpty) {
      return r'R$ 0.00';
    }
    final value = burgers.fold(
      0.0,
      (previousValue, element) => previousValue + element.price,
    );
    return r'R$ ' + value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          children: [
            Text(
              'Sacola',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: burgers.length,
                itemBuilder: (context, index) {
                  final model = burgers[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    leading: ClipOval(
                      child: Image.network(
                        model.image,
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    title: Text(model.title),
                    subtitle: Text(model.toMoney()),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline_rounded),
                      onPressed: () {
                        onRemove?.call(model);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Valor: $totalValue',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Finalizar compra'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onFinalize,
              child: const Text('Limpar sacola'),
            ),
          ],
        ),
      ),
    );
  }
}
