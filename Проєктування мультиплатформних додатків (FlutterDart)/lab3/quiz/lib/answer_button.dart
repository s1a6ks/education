import 'package:flutter/material.dart'; // Імпорт основного пакету Flutter.

class AnswerButton extends StatelessWidget {
  // Створення віджета AnswerButton як StatelessWidget.
  const AnswerButton({
    // Конструктор віджета AnswerButton.
    super.key,
    required this.answerText, // Обов'язковий параметр: текст відповіді, що відображається на кнопці.
    required this.onTap, // Обов'язковий параметр: функція, яка викликається при натисканні на кнопку.
  });

  final String
      answerText; // Оголошення фінальної змінної для зберігання тексту відповіді.
  final void Function()
      onTap; // Оголошення фінальної функції, яка буде викликатися при натисканні.

  @override
  Widget build(BuildContext context) {
    // Метод build описує, як відображати віджет.
    return ElevatedButton(
      // Віджет ElevatedButton для створення кнопки з піднятим ефектом.
      onPressed:
          onTap, // Встановлення функції onTap як обробника натискання кнопки.
      style: ElevatedButton.styleFrom(
        // Стилізація кнопки за допомогою ElevatedButton.styleFrom.
        padding: const EdgeInsets.symmetric(
          // Встановлення внутрішніх відступів кнопки.
          vertical: 10, // Вертикальні відступи.
          horizontal: 40, // Горизонтальні відступи.
        ),
        backgroundColor: const Color.fromARGB(255, 33, 1,
            95), // Встановлення кольору фону кнопки (темно-фіолетовий).
        foregroundColor:
            Colors.white, // Встановлення кольору тексту кнопки (білий).
        shape: RoundedRectangleBorder(
          // Встановлення форми кнопки з заокругленими краями.
          borderRadius: BorderRadius.circular(40), // Радіус заокруглення країв.
        ),
      ),
      child: Text(
        // Віджет для відображення тексту на кнопці.
        answerText, // Текст, який відображається на кнопці (отриманий з параметра answerText).
        textAlign: TextAlign.center, // Вирівнювання тексту по центру.
      ),
    );
  }
}
