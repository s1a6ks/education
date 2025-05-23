import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design)
import 'package:transparent_image/transparent_image.dart'; // Імпорт пакета для використання прозорого зображення як плейсхолдера

import 'package:meals/widgets/meal_item_trait.dart'; // Імпорт файлу з віджетом для відображення характеристик страви
import 'package:meals/models/meal.dart'; // Імпорт файлу з моделлю даних Страви

// Віджет MealItem є StatelessWidget, оскільки відображає дані страви та функцію натискання, передані йому
class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal, // Об'єкт страви, яку потрібно відобразити
    required this.onSelectMeal, // Функція зворотного виклику, яка викликається при натисканні на елемент страви
  });

  final Meal meal; // Страва для відображення
  final void Function(Meal meal)
  onSelectMeal; // Функція, яка виконується при виборі страви

  // Геттер для форматування тексту складності приготування (перша літера велика)
  String get complexityText {
    return meal.complexity.name[0]
            .toUpperCase() + // Перша літера назви enum у верхньому регістрі
        meal.complexity.name.substring(1); // Решта тексту назви enum
  }

  // Геттер для форматування тексту доступності за ціною (перша літера велика)
  String get affordabilityText {
    return meal.affordability.name[0]
            .toUpperCase() + // Перша літера назви enum у верхньому регістрі
        meal.affordability.name.substring(1); // Решта тексту назви enum
  }

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI елемента списку страв
    return Card(
      // Використання віджета Card для візуального оформлення елемента списку
      margin: const EdgeInsets.all(8), // Зовнішні відступи картки
      shape: RoundedRectangleBorder(
        // Форма картки
        borderRadius: BorderRadius.circular(8), // Заокруглення кутів картки
      ),
      clipBehavior: Clip.hardEdge, // Обрізання вмісту за формою картки
      elevation: 2, // Тінь під карткою
      child: InkWell(
        // Віджет InkWell робить картку клікабельною та додає візуальний ефект при натисканні
        onTap: () {
          // Функція, яка викликається при натисканні
          onSelectMeal(
            meal,
          ); // Виклик функції onSelectMeal, передаючи поточну страву
        },
        child: Stack(
          // Використання віджета Stack для накладання віджетів один на одного (текст та характеристики поверх зображення)
          children: [
            // Відображення зображення страви з ефектом плавного появи при завантаженні
            FadeInImage(
              placeholder: MemoryImage(
                kTransparentImage,
              ), // Прозоре зображення як плейсхолдер під час завантаження
              image: NetworkImage(
                meal.imageUrl,
              ), // Завантаження зображення з URL
              fit:
                  BoxFit
                      .cover, // Масштабування зображення для заповнення області
              height: 200, // Висота зображення
              width:
                  double.infinity, // Ширина зображення (на всю доступну ширину)
            ),
            Positioned(
              // Позиціонування віджета поверх зображення
              bottom: 0, // Прив'язка до нижнього краю
              left: 0, // Прив'язка до лівого краю
              right: 0, // Прив'язка до правого краю
              child: Container(
                // Контейнер для тексту та характеристик страви
                color: Colors.black54, // Напівпрозорий чорний фон
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ), // Внутрішні відступи
                child: Column(
                  // Вміст контейнера у вертикальному стовпці
                  children: [
                    // Відображення назви страви
                    Text(
                      meal.title, // Текст назви страви
                      maxLines: 2, // Максимальна кількість рядків для назви
                      textAlign:
                          TextAlign.center, // Вирівнювання тексту по центру
                      softWrap:
                          true, // Переносити текст на новий рядок за потреби
                      overflow:
                          TextOverflow
                              .ellipsis, // Якщо текст задовгий, додавати "..." в кінці
                      style: const TextStyle(
                        // Стиль тексту назви
                        fontSize: 20, // Розмір шрифту
                        fontWeight: FontWeight.bold, // Жирний шрифт
                        color: Colors.white, // Колір тексту - білий
                      ),
                    ),
                    const SizedBox(height: 12), // Вертикальний відступ
                    Row(
                      // Рядок для відображення характеристик страви
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center, // Вирівнювання елементів рядка по центру
                      children: [
                        // Використання віджета MealItemTrait для відображення тривалості приготування
                        MealItemTrait(
                          icon: Icons.schedule, // Іконка годинника
                          label:
                              '${meal.duration} min', // Текст: тривалість + " min"
                        ),
                        const SizedBox(width: 12), // Горизонтальний відступ
                        // Використання віджета MealItemTrait для відображення складності приготування
                        MealItemTrait(
                          icon: Icons.work, // Іконка роботи
                          label:
                              complexityText, // Текст: форматована складність
                        ),
                        const SizedBox(width: 12), // Горизонтальний відступ
                        // Використання віджета MealItemTrait для відображення доступності за ціною
                        MealItemTrait(
                          icon: Icons.attach_money, // Іконка грошей
                          label:
                              affordabilityText, // Текст: форматована доступність
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
