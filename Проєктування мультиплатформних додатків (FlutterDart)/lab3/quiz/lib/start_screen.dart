import 'package:flutter/material.dart'; // Імпорт основного пакету Flutter.
import 'package:google_fonts/google_fonts.dart'; // Імпорт пакету google_fonts для використання шрифтів Google.

class StartScreen extends StatelessWidget {
  // Створення віджета StartScreen як StatelessWidget.
  const StartScreen(this.startQuiz,
      {super.key}); // Конструктор віджета StartScreen, який приймає функцію startQuiz.

  final void Function()
      startQuiz; // Оголошення фінальної функції startQuiz, яка буде викликатися при натисканні кнопки.

  @override
  Widget build(context) {
    // Метод build описує, як відображати віджет.
    return Center(
      // Віджет Center центрує свій дочірній елемент на екрані.
      child: Column(
        // Віджет Column розташовує свої дочірні елементи вертикально.
        mainAxisSize: MainAxisSize
            .min, // Вказує Column займати мінімально необхідний вертикальний простір.
        children: [
          // Список дочірніх віджетів Column.
          Image.asset(
            // Віджет для відображення зображення з локальних ресурсів.
            'assets/images/quiz-logo.png', // Шлях до файлу зображення логотипу.
            width: 300, // Встановлення ширини зображення.
            color: const Color.fromARGB(150, 255, 255,
                255), // Застосування кольорового фільтра до зображення (робить його напівпрозорим білим).
          ),
          // Opacity( // Закоментований код для відображення логотипу з іншою прозорістю.
          //   opacity: 0.6,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          const SizedBox(
              height:
                  80), // Віджет SizedBox для створення вертикального проміжку.
          Text(
            // Віджет для відображення тексту.
            'Learn Flutter the fun way!', // Текст привітання.
            style: GoogleFonts.lato(
              // Стиль тексту з використанням шрифту Lato з пакету google_fonts.
              color: const Color.fromARGB(
                  255, 237, 223, 252), // Колір тексту (блідо-фіолетовий).
              fontSize: 24, // Розмір шрифту.
            ),
          ),
          const SizedBox(
              height:
                  30), // Віджет SizedBox для створення вертикального проміжку.
          OutlinedButton.icon(
            // Віджет для створення кнопки з обведенням та іконкою.
            onPressed:
                startQuiz, // Встановлення функції startQuiz як обробника натискання кнопки.
            style: OutlinedButton.styleFrom(
              // Стилізація кнопки.
              foregroundColor:
                  Colors.white, // Колір тексту та іконки кнопки (білий).
            ),
            icon: const Icon(
                Icons.arrow_right_alt), // Віджет іконки (стрілка праворуч).
            label: const Text('Start Quiz'), // Віджет тексту на кнопці.
          )
        ],
      ),
    );
  }
}
