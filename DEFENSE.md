# Защита Milestone 1 (3-5 минут)

## Pitch (1 минута)
Hello! My app is Bean & Brew. It is for students and young professionals who
do not want to wait in a queue. They browse the menu, choose a drink and a
size, and build an order. This is the first UI milestone, so the menu is demo
data and there is no real payment yet.

## Live demo (2 минуты)
1. **Menu.** Покажи поиск ("matcha"), очисти его, выбери чип Coffee, верни All.
   "Search and filters use setState, so the list updates instantly."
2. **Favorites.** Нажми сердечко у Latte, включи чип Favorites.
   "The heart saves a drink. The filter shows only saved drinks."
3. **Detail.** Открой Latte. Смени размер S -> L, увеличь количество.
   "The banner is a Stack with the heart on top. Tags use Wrap. The price
   changes with the size."
4. **Add to cart.** Нажми Add to cart, вернись, покажи значок на корзине.
5. **Cart.** Открой корзину, измени количество, покажи итог.
   "The same drink in the same size is one line. A different size is a new line."

## Code review (1 минута)
- `lib/` разделён на `screens`, `widgets`, `models`, `data`.
- `DrinkBanner` и `DrinkCard` переиспользуются в списке, деталях и корзине.
- `MenuScreen` хранит favorites и cart; детали и корзина получают callbacks.
- Показать `detail_screen.dart`: Stack, Wrap, bottomNavigationBar > Row > Expanded.

## Вопросы и ответы
**Stack?** Виджеты друг над другом: сердечко и бейдж поверх баннера.

**Expanded?** Занимает всё свободное место в Row/Column. Кнопка Add to cart
получает всю ширину, а длинное название не вытесняет цену.

**Wrap?** Как Row, но переносит элементы на новую строку, если не хватает места.

**StatefulWidget и setState?** Виджет с изменяемым состоянием. setState
меняет данные и просит Flutter перерисовать экран.

**Где хранится корзина?** В состоянии MenuScreen. Navigator.push открывает
экран поверх него, поэтому данные не теряются.

**Как детали передают данные назад?** Через callbacks (`onAddToCart`,
`onToggleFavorite`), которые MenuScreen передаёт в конструктор.

**Как считается сумма?** `unitPrice * quantity` для строки, `fold` суммирует
все строки. Цена размера = базовая цена + надбавка размера.

**Почему не BLoC / нет базы?** На первом этапе нужны StatefulWidget и
setState. API, база и BLoC добавятся в следующих этапах.

**Как избежали overflow?** Прокручиваемые экраны, Expanded, Wrap, обрезка
текста (ellipsis), горизонтальная прокрутка чипов. Говори "проверено" только
после реального запуска `flutter test` и эмулятора.
