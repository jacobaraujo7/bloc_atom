import 'package:asp/asp.dart';
import 'package:atomic_state/src/atom/cart_atom.dart';
import 'package:flutter/material.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    context.callback(() => cartBurgsState.value.length, (value) {
      if (cartBurgsState.value.isEmpty) {
        if (context.mounted) {
          Navigator.of(context).maybePop();
        }
      }
    });

    context.select(() => [cartBurgsState.value.length, totalValueComputed]);
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
                itemCount: cartBurgsState.value.length,
                itemBuilder: (context, index) {
                  final model = cartBurgsState.value[index];
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
                        removeBurgAction.setValue(model);
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
                  'Valor: $totalValueComputed',
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
              onPressed: () {
                cleanCartAction();
              },
              child: const Text('Limpar sacola'),
            ),
          ],
        ),
      ),
    );
  }
}
