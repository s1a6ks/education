import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter

import 'package:expense_tracker/widgets/expenses_list/expense_item.dart'; // Імпорт файлу з віджетом для відображення одного елемента витрати
import 'package:expense_tracker/models/expense.dart'; // Імпорт файлу з моделлю даних витрати

// Віджет ExpensesList є StatelessWidget, оскільки він лише відображає дані, які йому передаються
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses, // Список витрат, які потрібно відобразити
    required this.onRemoveExpense, // Функція зворотного виклику, яка викликається при видаленні витрати
  });

  final List<Expense> expenses; // Список витрат
  final void Function(Expense expense)
  onRemoveExpense; // Функція для видалення витрати

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length, // Кількість елементів у списку
      itemBuilder:
          (ctx, index) => Dismissible(
            // Віджет Dismissible дозволяє видаляти елемент свайпом
            key: ValueKey(
              expenses[index],
            ), // Унікальний ключ для кожного елемента списку, важливий для Dismissible
            background: Container(
              // Віджет, який відображається на фоні при свайпі
              color: Theme.of(context).colorScheme.error.withValues(
                alpha: (0.75 * 255).round().toDouble(),
              ), // Колір фону - колір помилки з певною прозорістю
              margin: EdgeInsets.symmetric(
                horizontal:
                    Theme.of(context)
                        .cardTheme
                        .margin!
                        .horizontal, // Горизонтальні відступи, що відповідають відступам CardTheme
              ),
            ),
            onDismissed: (direction) {
              // Функція, яка викликається після того, як елемент був видалений свайпом
              onRemoveExpense(
                expenses[index],
              ); // Виклик функції onRemoveExpense для видалення витрати з основного списку
            },
            child: ExpenseItem(
              expenses[index],
            ), // Віджет, який відображає один елемент витрати
          ),
    );
  }
}
