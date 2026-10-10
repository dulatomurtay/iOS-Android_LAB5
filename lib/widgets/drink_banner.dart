import 'package:flutter/material.dart';

import '../models/drink.dart';

/// Colourful gradient banner with a big icon. Uses a Stack, so extra
/// widgets (favorite button, badge) can be placed on top via [overlays].
/// The banner fills whatever size its parent gives it.
class DrinkBanner extends StatelessWidget {
  final Drink drink;
  final double iconSize;
  final List<Widget> overlays;

  const DrinkBanner({
    super.key,
    required this.drink,
    this.iconSize = 48,
    this.overlays = const [],
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            drink.color,
            Color.lerp(drink.color, Colors.black, 0.4)!,
          ],
        ),
      ),
      child: Stack(
        children: [
          Center(child: Icon(drink.icon, size: iconSize, color: Colors.white)),
          // Photo (optional). If the file is missing, the icon above stays.
          if (drink.image != null)
            Positioned.fill(
              child: Image.asset(
                drink.image!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            ),
          ...overlays,
        ],
      ),
    );
  }
}
