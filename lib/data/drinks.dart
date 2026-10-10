import 'package:flutter/material.dart';

import '../models/drink.dart';

/// Demo menu (fictional prices). Later milestones will load this from a REST API.
const List<Drink> drinks = [
  Drink(
    id: 'latte',
    image: 'assets/images/latte.jpg',
    name: 'Latte',
    category: 'Coffee',
    description:
        'Double espresso with steamed milk and a thin layer of silky foam. '
        'A soft, balanced classic for any time of day.',
    price: 1600,
    rating: 4.8,
    calories: 190,
    icon: Icons.local_cafe,
    color: Color(0xFF8D6E63),
    tags: ['Hot', 'Milk', 'Smooth'],
    badge: 'Bestseller',
  ),
  Drink(
    id: 'cappuccino',
    image: 'assets/images/cappuccino.jpg',
    name: 'Cappuccino',
    category: 'Coffee',
    description:
        'Equal parts espresso, steamed milk and thick foam. '
        'Rich aroma with a light, airy texture.',
    price: 1500,
    rating: 4.7,
    calories: 120,
    icon: Icons.coffee,
    color: Color(0xFF6D4C41),
    tags: ['Hot', 'Foamy'],
  ),
  Drink(
    id: 'flat_white',
    image: 'assets/images/flat_white.jpg',
    name: 'Flat White',
    category: 'Coffee',
    description:
        'Strong espresso with velvety microfoam milk. '
        'More coffee flavour and less foam than a latte.',
    price: 1700,
    rating: 4.6,
    calories: 150,
    icon: Icons.coffee_maker,
    color: Color(0xFF5D4037),
    tags: ['Hot', 'Strong'],
  ),
  Drink(
    id: 'iced_americano',
    image: 'assets/images/iced_americano.jpg',
    name: 'Iced Americano',
    category: 'Cold',
    description:
        'Espresso over ice and cold water. Clean, refreshing and '
        'sugar-free, ideal for a warm afternoon.',
    price: 1400,
    rating: 4.5,
    calories: 15,
    icon: Icons.ac_unit,
    color: Color(0xFF455A64),
    tags: ['Iced', 'Sugar-free'],
  ),
  Drink(
    id: 'berry_lemonade',
    image: 'assets/images/berry_lemonade.jpg',
    name: 'Berry Lemonade',
    category: 'Cold',
    description:
        'Fresh lemon, berry syrup and sparkling water over ice. '
        'Sweet, tangy and very refreshing.',
    price: 1500,
    rating: 4.3,
    calories: 110,
    icon: Icons.local_drink,
    color: Color(0xFFC2185B),
    tags: ['Iced', 'Fruity'],
  ),
  Drink(
    id: 'matcha_latte',
    image: 'assets/images/matcha_latte.jpg',
    name: 'Matcha Latte',
    category: 'Tea',
    description:
        'Ceremonial-style matcha whisked with steamed milk. '
        'Earthy, creamy and gently energising.',
    price: 1900,
    rating: 4.9,
    calories: 160,
    icon: Icons.eco,
    color: Color(0xFF558B2F),
    tags: ['Hot', 'Green tea', 'Creamy'],
    badge: 'New',
  ),
  Drink(
    id: 'masala_chai',
    image: 'assets/images/masala_chai.jpg',
    name: 'Masala Chai',
    category: 'Tea',
    description:
        'Black tea simmered with milk, cardamom, ginger and cinnamon. '
        'Warm, spicy and comforting.',
    price: 1300,
    rating: 4.4,
    calories: 140,
    icon: Icons.emoji_food_beverage,
    color: Color(0xFFB5651D),
    tags: ['Hot', 'Spiced'],
  ),
  Drink(
    id: 'cheesecake',
    image: 'assets/images/cheesecake.jpg',
    name: 'Cheesecake',
    category: 'Dessert',
    description:
        'Creamy New York style cheesecake on a buttery biscuit base '
        'with a berry topping.',
    price: 1800,
    rating: 4.7,
    calories: 380,
    icon: Icons.cake,
    color: Color(0xFFD27C8E),
    tags: ['Sweet', 'Slice'],
    hasSizes: false,
  ),
  Drink(
    id: 'croissant',
    image: 'assets/images/croissant.jpg',
    name: 'Croissant',
    category: 'Dessert',
    description:
        'Flaky, golden butter croissant baked every morning. '
        'Perfect with a cappuccino.',
    price: 1100,
    rating: 4.5,
    calories: 270,
    icon: Icons.bakery_dining,
    color: Color(0xFFC68B3E),
    tags: ['Fresh', 'Butter'],
    hasSizes: false,
  ),
];
