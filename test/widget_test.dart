import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coffee_house/data/drinks.dart';
import 'package:coffee_house/main.dart';
import 'package:coffee_house/screens/detail_screen.dart';

void main() {
  testWidgets('search filters the menu', (tester) async {
    await tester.pumpWidget(const CoffeeApp());
    expect(find.text('Latte'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'matcha');
    await tester.pump();

    expect(find.text('Latte'), findsNothing);
    expect(find.text('Matcha Latte'), findsOneWidget);
  });

  testWidgets('favorites and cart work across screens', (tester) async {
    await tester.pumpWidget(const CoffeeApp());

    // Mark the first drink (Latte) as favorite and show only favorites.
    await tester.tap(find.byTooltip('Add to favorites').first);
    await tester.pump();
    await tester.tap(find.text('Favorites'));
    await tester.pump();
    expect(find.text('Latte'), findsOneWidget);
    expect(find.text('Cappuccino'), findsNothing);

    // Open details and add to cart.
    await tester.tap(find.text('Latte'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('addToCart')));
    await tester.pump();

    // Back to the menu, then open the cart.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Cart'));
    await tester.pumpAndSettle();

    expect(find.text('Total'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final size in const [Size(320, 568), Size(390, 844), Size(1024, 768)]) {
    testWidgets('menu has no overflow at $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const CoffeeApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    for (final scale in const [1.0, 1.5]) {
      testWidgets('detail has no overflow at $size, text x$scale',
          (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            ),
            home: DetailScreen(
              drink: drinks.first,
              isFavorite: () => false,
              onToggleFavorite: () {},
              onAddToCart: (s, q) {},
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(
          find.byKey(const ValueKey('addToCart')).hitTestable(),
          findsOneWidget,
        );
      });
    }
  }
}
