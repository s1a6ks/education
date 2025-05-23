import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter

import 'package:expense_tracker/widgets/new_expense.dart'; // Імпорт файлу з віджетом для додавання нової витрати
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart'; // Імпорт файлу з віджетом для відображення списку витрат
import 'package:expense_tracker/models/expense.dart'; // Імпорт файлу з моделлю даних витрати
import 'package:expense_tracker/widgets/chart/chart.dart'; // Імпорт файлу з віджетом для відображення графіка витрат

// Віджет Expenses є StatefulWidget, оскільки його стан (список витрат) може змінюватися
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState(); // Створення стану для віджета Expenses
  }
}

// Клас _ExpensesState представляє стан віджета Expenses
class _ExpensesState extends State<Expenses> {
  // Приватний список для зберігання зареєстрованих витрат
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course', // Назва витрати
      amount: 19.99, // Сума витрати
      date: DateTime.now(), // Дата витрати (поточна дата)
      category: Category.work, // Категорія витрати (робота)
    ),
    Expense(
      title: 'Cinema', // Назва витрати
      amount: 15.69, // Сума витрати
      date: DateTime.now(), // Дата витрати (поточна дата)
      category: Category.leisure, // Категорія витрати (дозвілля)
    ),
  ];

  // Метод для відкриття модального вікна додавання нової витрати
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled:
          true, // Дозволяє модальному вікну займати більше половини екрана
      context: context, // Контекст поточного віджета
      builder:
          (ctx) => NewExpense(
            onAddExpense: _addExpense,
          ), // Побудова вмісту модального вікна за допомогою віджета NewExpense та передача функції _addExpense
    );
  }

  // Метод для додавання нової витрати до списку
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense); // Додавання витрати до списку
    }); // Виклик setState для оновлення UI
  }

  // Метод для видалення витрати зі списку
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(
      expense,
    ); // Отримання індексу видаленої витрати
    setState(() {
      _registeredExpenses.remove(expense); // Видалення витрати зі списку
    }); // Виклик setState для оновлення UI
    ScaffoldMessenger.of(
      context,
    ).clearSnackBars(); // Очищення попередніх SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(
          seconds: 3,
        ), // Тривалість відображення SnackBar
        content: const Text(
          'Expense deleted.',
        ), // Текст повідомлення у SnackBar
        action: SnackBarAction(
          label: 'Undo', // Текст кнопки "Скасувати"
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                expenseIndex,
                expense,
              ); // Вставлення видаленої витрати назад у список
            }); // Виклик setState для оновлення UI
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Визначення основного вмісту екрану (за замовчуванням - повідомлення про відсутність витрат)
    Widget mainContent = const Center(
      child: Text(
        'No expenses found. Start adding some!',
      ), // Повідомлення, якщо список витрат порожній
    );

    // Якщо список витрат не порожній, відображати список витрат
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses:
            _registeredExpenses, // Передача списку витрат до віджета ExpensesList
        onRemoveExpense:
            _removeExpense, // Передача функції для видалення витрати до віджета ExpensesList
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'), // Заголовок AppBar
        actions: [
          IconButton(
            onPressed:
                _openAddExpenseOverlay, // Виклик методу для відкриття модального вікна при натисканні
            icon: const Icon(Icons.add), // Іконка кнопки додавання
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses), // Відображення графіка витрат
          Expanded(
            child: mainContent,
          ), // Розширення основного вмісту для заповнення доступного простору
        ],
      ),
    );
  }
}
