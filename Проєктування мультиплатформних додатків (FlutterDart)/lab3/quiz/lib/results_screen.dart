import 'package:flutter/material.dart'; // Імпорт основного пакету Flutter.

import 'package:quiz/data/questions.dart'; // Імпорт списку питань.
import 'package:quiz/questions_summary/questions_summary.dart'; // Імпорт кастомного віджета QuestionsSummary.
import 'package:google_fonts/google_fonts.dart'; // Імпорт пакету google_fonts для використання шрифтів Google.

class ResultsScreen extends StatelessWidget {
  // Створення віджета ResultsScreen як StatelessWidget.
  const ResultsScreen({
    // Конструктор віджета ResultsScreen.
    super.key,
    required this.chosenAnswers, // Обов'язковий параметр: список відповідей, вибраних користувачем.
    required this.onRestart, // Обов'язковий параметр: функція для перезапуску вікторини.
  });

  final void Function() onRestart; // Оголошення фінальної функції onRestart.
  final List<String>
      chosenAnswers; // Оголошення фінального списку chosenAnswers.

  List<Map<String, Object>> get summaryData {
    // Getter для отримання зведених даних про результати вікторини.
    final List<Map<String, Object>> summary =
        []; // Ініціалізація порожнього списку summary.

    for (var i = 0; i < chosenAnswers.length; i++) {
      // Ітерування по списку вибраних відповідей.
      summary.add(
        // Додавання нової мапи до списку summary для кожного питання.
        {
          'question_index': i, // Індекс поточного питання.
          'question': questions[i].text, // Текст поточного питання.
          'correct_answer': questions[i].answers[
              0], // Правильна відповідь на поточне питання (перший елемент у списку відповідей).
          'user_answer': chosenAnswers[
              i] // Відповідь, вибрана користувачем на поточне питання.
        },
      );
    }

    return summary; // Повернення списку зведених даних.
  }

  @override
  Widget build(BuildContext context) {
    // Метод build описує, як відображати віджет ResultsScreen.
    final numTotalQuestions =
        questions.length; // Отримання загальної кількості питань.
    final numCorrectQuestions =
        summaryData // Обчислення кількості правильних відповідей.
            .where(
              // Фільтрація списку summaryData.
              (data) =>
                  data['user_answer'] ==
                  data[
                      'correct_answer'], // Умова фільтрації: відповідь користувача співпадає з правильною відповіддю.
            )
            .length; // Отримання кількості елементів, що задовольняють умову фільтрації.

    return SizedBox(
      // Віджет SizedBox для встановлення фіксованої ширини.
      width:
          double.infinity, // Встановлення ширини на всю доступну ширину екрану.
      child: Container(
        // Віджет-контейнер для застосування відступів.
        margin:
            const EdgeInsets.all(40), // Встановлення відступів з усіх боків.
        child: Column(
          // Віджет Column для вертикального розташування елементів.
          mainAxisAlignment: MainAxisAlignment
              .center, // Розташування дочірніх елементів по центру по вертикалі.
          children: [
            // Список дочірніх віджетів Column.
            Text(
              // Віджет для відображення тексту з результатами.
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!', // Форматований текст з кількістю правильних відповідей.
              style: GoogleFonts.lato(
                // Стиль тексту з використанням шрифту Lato.
                color: const Color.fromARGB(
                    255, 230, 200, 253), // Колір тексту (блідо-фіолетовий).
                fontSize: 20, // Розмір шрифту.
                fontWeight: FontWeight.bold, // Встановлення жирного шрифту.
              ),
              textAlign: TextAlign.center, // Вирівнювання тексту по центру.
            ),
            const SizedBox(
              // Віджет SizedBox для створення вертикального проміжку.
              height: 30,
            ),
            QuestionsSummary(
                summaryData), // Відображення віджета QuestionsSummary, передаючи зведені дані.
            const SizedBox(
              // Віджет SizedBox для створення вертикального проміжку.
              height: 30,
            ),
            TextButton.icon(
              // Віджет для створення текстової кнопки з іконкою.
              onPressed:
                  onRestart, // Встановлення функції onRestart як обробника натискання кнопки.
              style: TextButton.styleFrom(
                // Стилізація кнопки.
                foregroundColor:
                    Colors.white, // Колір тексту та іконки кнопки (білий).
              ),
              icon: const Icon(
                  Icons.refresh), // Віджет іконки (стрілка праворуч).
              label: const Text('Restart Quiz!'), // Віджет тексту на кнопці.
            )
          ],
        ),
      ),
    );
  }
}
