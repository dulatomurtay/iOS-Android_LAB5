import 'package:flutter/material.dart';

import '../models/drink.dart';
import 'drink_banner.dart';

/// One row of the menu: small banner, name, price, rating and a heart.
class DrinkCard extends StatelessWidget {
  final Drink drink;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const DrinkCard({
    super.key,
    required this.drink,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 88,
                  height: 88,
                  child: DrinkBanner(drink: drink, iconSize: 40),
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
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      drink.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: 1.2,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          formatPrice(drink.price),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: Color(0xFFE0A100),
                            ),
                            Text(' ${drink.rating}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip:
                    isFavorite ? 'Remove from favorites' : 'Add to favorites',
                onPressed: onFavorite,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
