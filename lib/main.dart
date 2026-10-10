import 'package:flutter/material.dart';

import 'screens/menu_screen.dart';

void main() => runApp(const CoffeeApp());

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bean & Brew',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6F4E37)),
        scaffoldBackgroundColor: const Color(0xFFFBF6F0),
      ),
      home: const MenuScreen(),
    );
  }
}
