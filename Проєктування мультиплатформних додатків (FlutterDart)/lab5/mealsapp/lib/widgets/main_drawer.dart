import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design, Drawer, ListTile тощо)

// Віджет MainDrawer є StatelessWidget, оскільки він відображає статичний контент та функцію для вибору екрану
class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  }); // Конструктор, який приймає функцію для вибору екрану

  final void Function(String identifier)
  onSelectScreen; // Функція зворотного виклику, яка викликається при виборі пункту меню (приймає ідентифікатор екрану)

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI бокового меню
    return Drawer(
      // Віджет Drawer - стандартна бічна панель навігації Material Design
      child: Column(
        // Вміст бокового меню, розташований у вертикальному стовпці
        children: [
          DrawerHeader(
            // Заголовок бокового меню
            padding: const EdgeInsets.all(20), // Внутрішні відступи заголовка
            decoration: BoxDecoration(
              // Оформлення заголовка
              gradient: LinearGradient(
                // Градієнтний фон
                colors: [
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer, // Колір первинного контейнера теми
                  Theme.of(context).colorScheme.primaryContainer.withOpacity(
                    0.8,
                  ), // Той самий колір, але з прозорістю
                ],
                begin:
                    Alignment
                        .topLeft, // Початок градієнта з верхнього лівого кута
                end:
                    Alignment
                        .bottomRight, // Кінець градієнта у нижньому правому куті
              ),
            ),
            child: Row(
              // Вміст заголовка (іконка та текст) у горизонтальному рядку
              children: [
                Icon(
                  Icons.fastfood, // Іконка їжі
                  size: 48, // Розмір іконки
                  color:
                      Theme.of(context)
                          .colorScheme
                          .primary, // Колір іконки з колірної схеми теми
                ),
                const SizedBox(width: 18), // Горизонтальний відступ
                Text(
                  'Cooking Up!', // Текст заголовка
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    // Стиль тексту заголовка
                    color:
                        Theme.of(context)
                            .colorScheme
                            .primary, // Колір тексту з колірної схеми теми
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            // Елемент списку меню (для пункту "Meals")
            leading: Icon(
              // Іконка пункту меню
              Icons.restaurant, // Іконка ресторану
              size: 26, // Розмір іконки
              color:
                  Theme.of(
                    context,
                  ).colorScheme.onBackground, // Колір іконки на фоні
            ),
            title: Text(
              // Текст пункту меню
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                // Стиль тексту
                color:
                    Theme.of(
                      context,
                    ).colorScheme.onBackground, // Колір тексту на фоні
                fontSize: 24, // Розмір шрифту
              ),
            ),
            onTap: () {
              // Функція, яка викликається при натисканні на пункт меню
              onSelectScreen(
                'meals',
              ); // Виклик функції onSelectScreen з ідентифікатором 'meals'
            },
          ),
          ListTile(
            // Елемент списку меню (для пункту "Filters")
            leading: Icon(
              // Іконка пункту меню
              Icons.settings, // Іконка налаштувань
              size: 26, // Розмір іконки
              color:
                  Theme.of(
                    context,
                  ).colorScheme.onBackground, // Колір іконки на фоні
            ),
            title: Text(
              // Текст пункту меню
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                // Стиль тексту
                color:
                    Theme.of(
                      context,
                    ).colorScheme.onBackground, // Колір тексту на фоні
                fontSize: 24, // Розмір шрифту
              ),
            ),
            onTap: () {
              // Функція, яка викликається при натисканні на пункт меню
              onSelectScreen(
                'filters',
              ); // Виклик функції onSelectScreen з ідентифікатором 'filters'
            },
          ),
        ],
      ),
    );
  }
}
