import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design)

import 'package:meals/models/category.dart'; // Імпорт файлу з моделлю даних Категорії

// Віджет CategoryGridItem є StatelessWidget, оскільки він відображає дані категорії та функцію для натискання, передані йому
class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category, // Об'єкт категорії, яку потрібно відобразити
    required this.onSelectCategory, // Функція зворотного виклику, яка викликається при натисканні на елемент
  });

  final Category category; // Категорія для відображення
  final void Function()
  onSelectCategory; // Функція, яка виконується при виборі категорії

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI елемента сітки категорії
    return InkWell(
      // Віджет InkWell робить його дочірній елемент клікабельним та додає візуальний ефект "чорнила" при натисканні
      onTap:
          onSelectCategory, // Функція, яка викликається при натисканні (передана через конструктор)
      splashColor: Theme.of(context).primaryColor, // Колір ефекту "чорнила"
      borderRadius: BorderRadius.circular(
        16,
      ), // Заокруглення кутів для ефекту "чорнила"
      child: Container(
        // Контейнер для вмісту елемента сітки
        padding: const EdgeInsets.all(16), // Внутрішні відступи контейнера
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [category.color.withOpacity(0.4), category.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          category.title, // Відображення назви категорії
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            // Стиль тексту назви категорії
            color:
                Theme.of(
                  context,
                ).colorScheme.onBackground, // Колір тексту на фоні
          ),
        ),
      ),
    );
  }
}
