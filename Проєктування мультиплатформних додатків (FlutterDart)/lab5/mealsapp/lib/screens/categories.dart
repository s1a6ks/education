import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design та навігації)

import 'package:meals/data/dummy_data.dart'; // Імпорт файлу з фіктивними даними (доступні категорії)
import 'package:meals/models/meal.dart'; // Імпорт файлу з моделлю даних Страви
import 'package:meals/widgets/category_grid_item.dart'; // Імпорт файлу з віджетом для відображення одного елемента сітки категорій
import 'package:meals/screens/meals.dart'; // Імпорт файлу з віджетом екрану для відображення списку страв
import 'package:meals/models/category.dart'; // Імпорт файлу з моделлю даних Категорії

// Віджет CategoriesScreen є StatelessWidget, оскільки він лише відображає сітку категорій
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite, // Функція зворотного виклику для перемикання статусу "улюблене", яка передається далі на екран страв
    required this.availableMeals, // Список доступних страв (може бути відфільтрований)
  });

  final void Function(Meal meal)
  onToggleFavorite; // Функція для обробки улюблених страв
  final List<Meal>
  availableMeals; // Список страв, з яких буде здійснюватися вибірка

  // Метод для обробки вибору категорії користувачем
  void _selectCategory(BuildContext context, Category category) {
    // Фільтруємо список доступних страв, залишаючи лише ті, які належать до обраної категорії
    final filteredMeals =
        availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    // Здійснюємо навігацію на новий екран (екран страв)
    Navigator.of(context).push(
      MaterialPageRoute(
        // Створення маршруту до нового екрану
        builder:
            (ctx) => MealsScreen(
              // Побудова віджета MealsScreen
              title:
                  category
                      .title, // Передача назви категорії як заголовка екрану страв
              meals:
                  filteredMeals, // Передача відфільтрованого списку страв на екран страв
              onToggleFavorite:
                  onToggleFavorite, favoriteMeals: [], // Передача функції обробки улюблених страв далі
            ),
      ),
    ); // Navigator.push(context, route) - альтернативний спосіб
  }

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI екрану категорій
    return GridView(
      padding: const EdgeInsets.all(24), // Встановлення відступів навколо сітки
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Налаштування делегата сітки (кількість елементів по поперечній осі фіксована)
        crossAxisCount:
            2, // Кількість стовпців у сітці (2 елементи по горизонталі)
        childAspectRatio:
            3 /
            2, // Співвідношення сторін кожного елемента сітки (ширина/висота)
        crossAxisSpacing: 20, // Відступ між елементами по горизонталі
        mainAxisSpacing: 20, // Відступ між елементами по вертикалі
      ),
      children: [
        // availableCategories.map((category) => CategoryGridItem(category: category)).toList() - альтернативний спосіб створення списку віджетів
        // Перебираємо кожну доступну категорію та створюємо для неї віджет CategoryGridItem
        for (final category in availableCategories)
          CategoryGridItem(
            category:
                category, // Передача об'єкта категорії до віджета елемента сітки
            onSelectCategory: () {
              // Передача функції зворотного виклику, яка буде викликана при натисканні на елемент сітки
              _selectCategory(
                context,
                category,
              ); // Виклик приватного методу _selectCategory
            },
          ),
      ],
    );
  }
}
