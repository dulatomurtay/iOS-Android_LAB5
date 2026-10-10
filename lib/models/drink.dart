import 'package:flutter/material.dart';

/// Cup sizes. Each size adds a fixed amount to the base price.
enum DrinkSize { small, medium, large }

extension DrinkSizeInfo on DrinkSize {
  String get label => switch (this) {
        DrinkSize.small => 'S',
        DrinkSize.medium => 'M',
        DrinkSize.large => 'L',
      };

  String get volume => switch (this) {
        DrinkSize.small => '250 ml',
        DrinkSize.medium => '350 ml',
        DrinkSize.large => '450 ml',
      };

  int get extraPrice => switch (this) {
        DrinkSize.small => 0,
        DrinkSize.medium => 300,
        DrinkSize.large => 600,
      };
}

/// One item of the menu (a drink or a dessert).
class Drink {
  final String id;
  final String name;
  final String category;
  final String description;
  final int price; // base price in KZT (size S)
  final double rating;
  final int calories;
  final IconData icon;
  final Color color;
  final List<String> tags;
  final bool hasSizes;
  final String? badge;
  final String? image; // e.g. assets/images/latte.jpg

  const Drink({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.calories,
    required this.icon,
    required this.color,
    this.tags = const [],
    this.hasSizes = true,
    this.badge,
    this.image,
  });

  /// Price for the chosen size (desserts have a single size).
  int priceFor(DrinkSize size) => hasSizes ? price + size.extraPrice : price;
}

/// A line in the cart: one drink in one size with a quantity.
class CartItem {
  final Drink drink;
  final DrinkSize size;
  int quantity;

  CartItem({required this.drink, required this.size, this.quantity = 1});

  int get unitPrice => drink.priceFor(size);
  int get total => unitPrice * quantity;
}

/// 12500 -> "12 500 ₸"
String formatPrice(int value) {
  final spaced = value.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (match) => ' ',
      );
  return '$spaced ₸';
}
