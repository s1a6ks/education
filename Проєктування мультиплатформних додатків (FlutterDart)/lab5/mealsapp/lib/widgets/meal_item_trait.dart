import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Icon, Text, Row, SizedBox, Colors)

// Віджет MealItemTrait є StatelessWidget, оскільки він відображає іконку та текст, передані йому
class MealItemTrait extends StatelessWidget {
  // Конструктор, який приймає іконку та текст (мітку) як обов'язкові параметри
  const MealItemTrait({
    super.key,
    required this.icon, // Іконка для відображення
    required this.label, // Текст (мітка) для відображення
  });

  final IconData icon; // Властивість для зберігання даних іконки
  final String label; // Властивість для зберігання тексту мітки

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI для цього віджета
    return Row(
      children: [
        // Використання віджета Row для горизонтального розташування іконки та тексту
        Icon(
          icon, // Відображення переданої іконки
          size: 17, // Розмір іконки
          color: Colors.white, // Колір іконки - білий
        ),
        const SizedBox(
          width: 6,
        ), // Додавання горизонтального відступу між іконкою та текстом
        Text(
          label, // Відображення переданого тексту мітки
          style: const TextStyle(
            // Стиль тексту
            color: Colors.white, // Колір тексту - білий
          ),
        ),
      ],
    );
  }
}
