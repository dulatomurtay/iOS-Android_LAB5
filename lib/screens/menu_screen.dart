import 'package:flutter/material.dart';

import '../data/drinks.dart';
import '../models/drink.dart';
import '../widgets/drink_card.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';

/// Home screen: search, filters and the list of drinks.
/// It owns the shared state (favorites + cart) and passes it to other screens.
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const _categories = ['All', 'Coffee', 'Cold', 'Tea', 'Dessert'];

  final _searchController = TextEditingController();
  final Set<String> _favorites = {};
  final List<CartItem> _cart = [];

  String _query = '';
  String _category = 'All';
  bool _onlyFavorites = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Drink> get _visibleDrinks {
    final q = _query.toLowerCase();
    return drinks.where((d) {
      final matchesCategory = _category == 'All' || d.category == _category;
      final matchesFavorite = !_onlyFavorites || _favorites.contains(d.id);
      final matchesQuery = q.isEmpty ||
          d.name.toLowerCase().contains(q) ||
          d.category.toLowerCase().contains(q);
      return matchesCategory && matchesFavorite && matchesQuery;
    }).toList();
  }

  int get _cartCount => _cart.fold<int>(0, (sum, item) => sum + item.quantity);

  void _toggleFavorite(String id) {
    setState(() {
      if (!_favorites.remove(id)) _favorites.add(id);
    });
  }

  void _addToCart(Drink drink, DrinkSize size, int quantity) {
    setState(() {
      final index = _cart
          .indexWhere((c) => c.drink.id == drink.id && c.size == size);
      if (index == -1) {
        _cart.add(CartItem(drink: drink, size: size, quantity: quantity));
      } else {
        _cart[index].quantity += quantity;
      }
    });
  }

  void _openDetail(Drink drink) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(
          drink: drink,
          isFavorite: () => _favorites.contains(drink.id),
          onToggleFavorite: () => _toggleFavorite(drink.id),
          onAddToCart: (size, quantity) => _addToCart(drink, size, quantity),
        ),
      ),
    );
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => CartScreen(
          items: _cart,
          onChanged: () => setState(() {}),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final visible = _visibleDrinks;
    final count = _cartCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bean & Brew',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: _openCart,
            icon: Badge(
              isLabelVisible: count > 0,
              label: Text('$count'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Welcome banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good coffee,\ngood day',
                              style: TextStyle(
                                fontSize: 26,
                                height: 1.15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Order ahead and skip the line.'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.coffee, size: 56, color: scheme.primary),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Search
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value.trim()),
                  decoration: InputDecoration(
                    hintText: 'Search drinks and desserts',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Clear search',
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Filters (scroll sideways on narrow screens)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        avatar: const Icon(Icons.favorite, size: 18),
                        label: const Text('Favorites'),
                        selected: _onlyFavorites,
                        onSelected: (value) =>
                            setState(() => _onlyFavorites = value),
                      ),
                      for (final c in _categories)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: _category == c,
                            onSelected: (_) => setState(() => _category = c),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Menu',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text('${visible.length} items'),
                  ],
                ),
                const SizedBox(height: 12),

                if (visible.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 48, color: Colors.black38),
                        SizedBox(height: 8),
                        Text(
                          'Nothing found. Try another search or filter.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                for (final drink in visible)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DrinkCard(
                      drink: drink,
                      isFavorite: _favorites.contains(drink.id),
                      onTap: () => _openDetail(drink),
                      onFavorite: () => _toggleFavorite(drink.id),
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
