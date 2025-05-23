import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter

import 'package:expense_tracker/widgets/chart/chart_bar.dart'; // Імпорт файлу з віджетом для відображення одного стовпця діаграми
import 'package:expense_tracker/models/expense.dart'; // Імпорт файлу з моделлю даних витрати

// Віджет Chart є StatelessWidget, оскільки він лише відображає дані, які йому передаються
class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.expenses,
  }); // Конструктор, який приймає список витрат

  final List<Expense> expenses; // Список витрат для відображення на діаграмі

  // Геттер, який обробляє список витрат та групує їх за категоріями
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(
        expenses,
        Category.food,
      ), // Створення "відра" витрат для категорії "їжа"
      ExpenseBucket.forCategory(
        expenses,
        Category.leisure,
      ), // Створення "відра" витрат для категорії "дозвілля"
      ExpenseBucket.forCategory(
        expenses,
        Category.travel,
      ), // Створення "відра" витрат для категорії "подорожі"
      ExpenseBucket.forCategory(
        expenses,
        Category.work,
      ), // Створення "відра" витрат для категорії "робота"
    ];
  }

  // Геттер, який обчислює максимальну загальну суму витрат серед усіх категорій
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense =
            bucket
                .totalExpenses; // Оновлення максимальної суми, якщо знайдено більшу
      }
    }

    return maxTotalExpense; // Повернення максимальної загальної суми
  }

  @override
  Widget build(BuildContext context) {
    // Визначення, чи використовується темна тема
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(
        16,
      ), // Встановлення відступів навколо діаграми
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ), // Встановлення внутрішніх відступів
      width: double.infinity, // Займає всю доступну ширину
      height: 180, // Встановлення фіксованої висоти для діаграми
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Заокруглення кутів контейнера
        gradient: LinearGradient(
          // Створення градієнтного фону
          colors: [
            Theme.of(context).colorScheme.primary.withValues(
              alpha: (.65 * 255).round().toDouble(),
            ), // Початковий колір градієнта (первинний колір теми з прозорістю)
            Theme.of(context).colorScheme.primary.withValues(
              alpha: 0,
            ), // Кінцевий колір градієнта (повністю прозорий)
          ],
          begin: Alignment.bottomCenter, // Початок градієнта знизу по центру
          end: Alignment.topCenter, // Кінець градієнта зверху по центру
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .end, // Вирівнювання стовпців по нижньому краю
              children: [
                for (final bucket
                    in buckets) // Цикл для створення стовпця діаграми для кожної категорії
                  ChartBar(
                    fill:
                        bucket.totalExpenses ==
                                0 // Якщо загальна сума витрат у категорії дорівнює 0
                            ? 0 // Заповнення стовпця буде 0
                            : bucket.totalExpenses /
                                maxTotalExpense, // Інакше - відношення загальної суми до максимальної суми
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12), // Додавання вертикального відступу
          Row(
            children:
                buckets // Прохід по списку "відер" з витратами
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ), // Встановлення горизонтальних відступів для іконок
                          child: Icon(
                            categoryIcons[bucket
                                .category], // Відображення іконки категорії
                            color:
                                isDarkMode // Вибір кольору іконки залежно від теми
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondary // Вторинний колір для темної теми
                                    : Theme.of(
                                      context,
                                    ).colorScheme.primary.withValues(
                                      alpha: (0.7 * 255).round().toDouble(),
                                    ), // Первинний колір з прозорістю для світлої теми
                          ),
                        ),
                      ),
                    )
                    .toList(), // Перетворення відображених іконок на список
          ),
        ],
      ),
    );
  }
}
