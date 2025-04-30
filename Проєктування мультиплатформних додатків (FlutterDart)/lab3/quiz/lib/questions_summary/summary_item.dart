import 'package:flutter/material.dart'; // Імпорт основного пакету Flutter.
import 'package:google_fonts/google_fonts.dart'; // Імпорт пакету google_fonts для використання шрифтів Google.

import 'package:quiz/questions_summary/question_identifier.dart'; // Імпорт кастомного віджета QuestionIdentifier.

class SummaryItem extends StatelessWidget {
  // Створення віджета SummaryItem як StatelessWidget.
  const SummaryItem(this.itemData,
      {super.key}); // Конструктор віджета SummaryItem, який приймає мапу itemData.

  final Map<String, Object>
      itemData; // Оголошення фінальної мапи itemData, що містить інформацію про результат одного питання.

  @override
  Widget build(BuildContext context) {
    // Метод build описує, як відображати віджет SummaryItem.
    final isCorrectAnswer = // Визначення, чи була відповідь користувача правильною.
        itemData['user_answer'] == itemData['correct_answer'];

    return Padding(
      // Віджет Padding для додавання відступів навколо елемента.
      padding: const EdgeInsets.symmetric(
        // Встановлення симетричних вертикальних відступів.
        vertical: 8,
      ),
      child: Row(
        // Віджет Row для горизонтального розташування дочірніх елементів.
        crossAxisAlignment: CrossAxisAlignment
            .start, // Вирівнювання дочірніх елементів по верхньому краю.
        children: [
          // Список дочірніх віджетів Row.
          QuestionIdentifier(
            // Відображення ідентифікатора питання.
            isCorrectAnswer:
                isCorrectAnswer, // Передача інформації про правильність відповіді до віджета QuestionIdentifier.
            questionIndex: itemData['question_index']
                as int, // Передача індексу питання до віджета QuestionIdentifier.
          ),
          const SizedBox(
              width:
                  20), // Віджет SizedBox для створення горизонтального проміжку.
          Expanded(
            // Віджет Expanded займає весь доступний простір у Row.
            child: Column(
              // Віджет Column для вертикального розташування тексту питання та відповідей.
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Вирівнювання дочірніх елементів по лівому краю.
              children: [
                // Список дочірніх віджетів Column.
                Text(
                  // Відображення тексту питання.
                  itemData['question']
                      as String, // Отримання тексту питання з мапи itemData.
                  style: GoogleFonts.lato(
                    // Стиль тексту з використанням шрифту Lato.
                    color: Colors.white, // Колір тексту (білий).
                    fontSize: 16, // Розмір шрифту.
                    fontWeight: FontWeight.bold, // Встановлення жирного шрифту.
                  ),
                ),
                const SizedBox(
                  // Віджет SizedBox для створення вертикального проміжку.
                  height: 5,
                ),
                Text(
                    itemData['user_answer']
                        as String, // Відображення відповіді користувача.
                    style: const TextStyle(
                      // Стиль тексту відповіді користувача.
                      color: Color.fromARGB(255, 202, 171,
                          252), // Колір тексту (блідо-фіолетовий).
                    )),
                Text(
                    itemData['correct_answer']
                        as String, // Відображення правильної відповіді.
                    style: const TextStyle(
                      // Стиль тексту правильної відповіді.
                      color: Color.fromARGB(
                          255, 181, 254, 246), // Колір тексту (блакитний).
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
