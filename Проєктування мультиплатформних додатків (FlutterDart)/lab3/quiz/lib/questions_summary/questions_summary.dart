import 'package:flutter/material.dart'; // Імпорт основного пакету Flutter.

import 'package:quiz/questions_summary/summary_item.dart'; // Імпорт кастомного віджета SummaryItem.

class QuestionsSummary extends StatelessWidget {
  // Створення віджета QuestionsSummary як StatelessWidget.
  const QuestionsSummary(this.summaryData,
      {super.key}); // Конструктор віджета QuestionsSummary, який приймає список summaryData.

  final List<Map<String, Object>>
      summaryData; // Оголошення фінального списку summaryData, що містить інформацію про результати.

  @override
  Widget build(BuildContext context) {
    // Метод build описує, як відображати віджет QuestionsSummary.
    return SizedBox(
      // Віджет SizedBox для встановлення фіксованої висоти.
      height: 400, // Встановлення висоти контейнера для списку результатів.
      child: SingleChildScrollView(
        // Віджет SingleChildScrollView робить дочірній елемент прокручуваним, якщо він не вміщується.
        child: Column(
          // Віджет Column для вертикального розташування елементів.
          children: summaryData.map(
            // Використання методу map для перетворення кожного елемента списку summaryData на віджет.
            (data) {
              // Анонімна функція, яка приймає мапу даних про результат одного питання.
              return SummaryItem(
                  data); // Повернення віджета SummaryItem, якому передаються дані про поточне питання.
            },
          ).toList(), // Перетворення результату map() на список віджетів.
        ),
      ),
    );
  }
}
