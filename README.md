# Bean & Brew (coffee_house)

Flutter coffee-ordering app. Covers **LAB 5** (adaptive item detail screen) and
**Capstone Milestone 1** (initial MVP UI).

## Concept
Busy students and young professionals want to pick a drink quickly, choose a
size and order ahead. Bean & Brew shows a small menu of coffee, tea, cold
drinks and desserts. The data is a fictional local demo menu (prices in KZT).

## Features
- Menu feed: search, category filter chips, "Favorites" filter, empty state
- Detail screen: `Stack` banner with favorite button and badge, title + price
  (`Row` + `Expanded`), rating + calories and tags (`Wrap`), size picker,
  quantity stepper
- Sticky bottom bar: full-width "Add to cart" button (`Row` > `Expanded`)
- Cart: grouped by drink + size, quantity controls, remove, total
- Cart badge in the app bar; favorites and cart survive navigation
- `StatefulWidget` + `setState` only, no third-party packages

## Project structure
```
lib/
  main.dart                    app entry + theme
  models/drink.dart            Drink, DrinkSize, CartItem, formatPrice
  data/drinks.dart             demo menu
  screens/menu_screen.dart     feed, filters, shared state (favorites, cart)
  screens/detail_screen.dart   details, size, quantity, add to cart
  screens/cart_screen.dart     cart lines and total
  widgets/drink_banner.dart    reusable Stack banner
  widgets/drink_card.dart      reusable menu card
test/widget_test.dart          interaction and layout tests
```

## Requirements map
| Requirement | Where |
|---|---|
| Stack cover + badge/bookmark | `DrinkBanner`, `DetailScreen` |
| Title, rating, price with Row/Wrap | `DetailScreen` |
| Category badges | `Wrap` + `Chip` |
| Sticky full-width button via Expanded | `DetailScreen.bottomNavigationBar` |
| Column, Row, Card on the feed | `MenuScreen`, `DrinkCard` |
| StatefulWidget + setState | `MenuScreen`, `DetailScreen`, `CartScreen` |
| Folder structure | `screens`, `widgets`, `models`, `data` |
| No RenderFlex overflow | scrolling, `Expanded`, `Wrap`, ellipsis |

## Photos
Put JPG files into `assets/images/`. The file name must match the drink id
from `lib/data/drinks.dart`: `latte.jpg`, `cappuccino.jpg`, `flat_white.jpg`,
`iced_americano.jpg`, `berry_lemonade.jpg`, `matcha_latte.jpg`,
`masala_chai.jpg`, `cheesecake.jpg`, `croissant.jpg`. A missing photo is fine:
the gradient and icon are shown instead. After adding files, stop the app and
run it again (hot reload does not pick up new assets).

## Run
```sh
flutter create --platforms=android,web --project-name coffee_house .
flutter pub get
flutter analyze
flutter test
flutter run
```
The dot at the end of the first command is required. If it asks about
overwriting, keep the supplied `lib`, `test` and `pubspec.yaml`.

## Validation status
This source was prepared without a Flutter SDK, so `flutter analyze`,
`flutter test` and an emulator check have NOT been run yet. Run the commands
above, fix anything they report, and only then claim "zero overflow".
Add real screenshots to this README before submitting.

## Scope and next steps
Selections reset on a full restart. No API, database, login or real payment
yet. Next milestones: REST API for the menu, local database for favorites and
orders, BLoC architecture.

## GitHub
```sh
git init
git add .
git commit -m "Bean & Brew: Milestone 1"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/coffee_house.git
git push -u origin main
```
