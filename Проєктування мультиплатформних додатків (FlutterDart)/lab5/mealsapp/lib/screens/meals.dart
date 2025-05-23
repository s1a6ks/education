import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design та навігації)

import 'package:meals/models/meal.dart'; // Імпорт файлу з моделлю даних Страви
import 'package:meals/screens/meal_details.dart'; // Імпорт файлу з віджетом екрану деталей страви
import 'package:meals/widgets/meal_item.dart'; // Імпорт файлу з віджетом для відображення одного елемента списку страв

// Віджет MealsScreen є StatelessWidget, оскільки відображає список страв та заголовок, передані йому
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title, // Необов'язковий параметр: заголовок екрану (наприклад, назва категорії)
    required this.meals, // Обов'язковий параметр: список страв для відображення
    required this.onToggleFavorite, // Обов'язковий параметр: функція зворотного виклику для обробки "улюблене" (передається далі)
  });

  final String? title; // Заголовок екрану (може бути null)
  final List<Meal> meals; // Список страв
  final void Function(Meal meal)
  onToggleFavorite; // Функція для обробки улюблених страв

  // Метод для обробки вибору страви зі списку
  void selectMeal(BuildContext context, Meal meal) {
    // Здійснюємо навігацію на екран деталей страви
    Navigator.of(context).push(
      MaterialPageRoute(
        // Створення маршруту до екрану деталей страви
        builder:
            (ctx) => MealDetailsScreen(
              // Побудова віджета MealDetailsScreen
              meal: meal, // Передача обраної страви на екран деталей
              onToggleFavorite:
                  onToggleFavorite, // Передача функції обробки улюблених страв далі
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Визначення вмісту, який буде відображено, якщо список страв порожній
    Widget content = Center(
      child: Column(
        mainAxisSize:
            MainAxisSize
                .min, // Займає мінімальний необхідний розмір по головній осі (вертикалі)
        children: [
          // Текст повідомлення про відсутність страв
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              // Стиль тексту заголовка
              color: Theme.of(context).colorScheme.onBackground, // Колір тексту
            ),
          ),
          const SizedBox(height: 16), // Додавання вертикального відступу
          // Текст підказки
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              // Стиль основного тексту
              color: Theme.of(context).colorScheme.onBackground, // Колір тексту
            ),
          ),
        ],
      ),
    );

    // Якщо список страв не порожній, вміст екрану буде списком страв
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length, // Кількість елементів у списку
        itemBuilder:
            (ctx, index) => MealItem(
              // Побудова віджета MealItem для кожного елемента списку
              meal:
                  meals[index], // Передача поточної страви до віджета MealItem
              onSelectMeal: (meal) {
                // Передача функції зворотного виклику, яка викликається при натисканні на елемент списку
                selectMeal(
                  context,
                  meal,
                ); // Виклик приватного методу selectMeal
              },
            ),
      );
    }

    // Якщо заголовок екрану не задано (null), повертаємо лише вміст без AppBar та Scaffold
    if (title == null) {
      return content;
    }

    // Якщо заголовок задано, повертаємо Scaffold з AppBar та вмістом
    return Scaffold(
      appBar: AppBar(
        // Панель застосунку
        title: Text(
          title!,
        ), // Заголовок панелі застосунку (використовуємо ! для "null assertion", оскільки перевірили вище)
      ),
      body:
          content, // Тіло екрану - визначений вище вміст (список або повідомлення)
    );
  }
}
