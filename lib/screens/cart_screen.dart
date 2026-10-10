import 'package:flutter/material.dart';

import '../models/drink.dart';
import '../widgets/drink_banner.dart';

/// Cart: change quantities, remove lines and see the total.
/// [items] is the list owned by the menu screen; [onChanged] tells it to
/// refresh (for example the cart badge).
class CartScreen extends StatefulWidget {
  final List<CartItem> items;
  final VoidCallback onChanged;

  const CartScreen({super.key, required this.items, required this.onChanged});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int get _total => widget.items.fold<int>(0, (sum, item) => sum + item.total);

  void _changeQuantity(CartItem item, int delta) {
    setState(() {
      item.quantity += delta;
      if (item.quantity <= 0) widget.items.remove(item);
    });
    widget.onChanged();
  }

  void _remove(CartItem item) {
    setState(() => widget.items.remove(item));
    widget.onChanged();
  }

  void _checkout() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Demo only: payment is not implemented')),
      );
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Your cart')),
      body: SafeArea(
        child: items.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 56, color: Colors.black38),
                      SizedBox(height: 12),
                      Text(
                        'Your cart is empty.\nAdd something tasty from the menu.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _CartLine(
                        item: item,
                        onMinus: () => _changeQuantity(item, -1),
                        onPlus: () => _changeQuantity(item, 1),
                        onRemove: () => _remove(item),
                      );
                    },
                  ),
                ),
              ),
      ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Material(
              elevation: 8,
              color: Colors.white,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Total'),
                          Text(
                            formatPrice(_total),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: _checkout,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                          ),
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _CartLine extends StatelessWidget {
  final CartItem item;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onRemove;

  const _CartLine({
    required this.item,
    required this.onMinus,
    required this.onPlus,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final drink = item.drink;
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 56,
                    height: 56,
                    child: DrinkBanner(drink: drink, iconSize: 28),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drink.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        drink.hasSizes
                            ? 'Size ${item.size.label} (${item.size.volume}) - ${formatPrice(item.unitPrice)}'
                            : formatPrice(item.unitPrice),
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Remove',
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton.outlined(
                  tooltip: 'Decrease quantity',
                  onPressed: onMinus,
                  icon: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    '${item.quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton.outlined(
                  tooltip: 'Increase quantity',
                  onPressed: onPlus,
                  icon: const Icon(Icons.add),
                ),
                const Spacer(),
                Text(
                  formatPrice(item.total),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
