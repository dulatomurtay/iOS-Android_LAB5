import 'package:flutter/material.dart';

import '../models/drink.dart';
import '../widgets/drink_banner.dart';

/// Detail screen: Stack banner with favorite button, title/price/rating,
/// tags, size picker, quantity and a sticky "Add to cart" bar.
class DetailScreen extends StatefulWidget {
  final Drink drink;
  final bool Function() isFavorite;
  final VoidCallback onToggleFavorite;
  final void Function(DrinkSize size, int quantity) onAddToCart;

  const DetailScreen({
    super.key,
    required this.drink,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DrinkSize _size = DrinkSize.small;
  int _quantity = 1;

  int get _unitPrice => widget.drink.priceFor(_size);

  void _toggleFavorite() {
    widget.onToggleFavorite();
    setState(() {});
  }

  void _addToCart() {
    widget.onAddToCart(_size, _quantity);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${widget.drink.name} x$_quantity added to cart'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.drink;
    final isFavorite = widget.isFavorite();

    return Scaffold(
      appBar: AppBar(title: Text(d.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner with overlays (Stack)
                  SizedBox(
                    height: 240,
                    child: DrinkBanner(
                      drink: d,
                      iconSize: 110,
                      overlays: [
                        Positioned(
                          top: 12,
                          right: 12,
                          child: IconButton.filledTonal(
                            tooltip: isFavorite
                                ? 'Remove from favorites'
                                : 'Add to favorites',
                            onPressed: _toggleFavorite,
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                          ),
                        ),
                        if (d.badge != null)
                          Positioned(
                            left: 12,
                            bottom: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                d.badge!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: d.color,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                d.name,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              formatPrice(_unitPrice),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Rating + calories
                        Wrap(
                          spacing: 16,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFE0A100),
                                ),
                                Text(' ${d.rating} / 5'),
                              ],
                            ),
                            Text('${d.calories} kcal'),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Category + tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            Chip(label: Text(d.category)),
                            for (final tag in d.tags) Chip(label: Text(tag)),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Size picker (drinks only)
                        if (d.hasSizes) ...[
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SegmentedButton<DrinkSize>(
                            showSelectedIcon: false,
                            segments: [
                              for (final s in DrinkSize.values)
                                ButtonSegment<DrinkSize>(
                                  value: s,
                                  label: Text(s.label),
                                ),
                            ],
                            selected: {_size},
                            onSelectionChanged: (selection) =>
                                setState(() => _size = selection.first),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _size.volume,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Quantity
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Quantity',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton.outlined(
                              tooltip: 'Decrease quantity',
                              onPressed: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                              icon: const Icon(Icons.remove),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            IconButton.outlined(
                              tooltip: 'Increase quantity',
                              onPressed: _quantity < 10
                                  ? () => setState(() => _quantity++)
                                  : null,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          d.description,
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Sticky action bar: the button takes the full width via Expanded
      bottomNavigationBar: Material(
        elevation: 8,
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    key: const ValueKey('addToCart'),
                    onPressed: _addToCart,
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text(
                      'Add to cart  ${formatPrice(_unitPrice * _quantity)}',
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                    ),
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
