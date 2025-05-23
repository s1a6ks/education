import 'package:flutter/material.dart'; // Імпорт бібліотеки віджетів Flutter (для використання Icons)
import 'package:uuid/uuid.dart'; // Імпорт бібліотеки для генерації унікальних ID
import 'package:intl/intl.dart'; // Імпорт бібліотеки для форматування дат

final formatter =
    DateFormat.yMd(); // Створення об'єкта DateFormat для форматування дати у форматі рік-місяць-день

const uuid =
    Uuid(); // Створення екземпляра класу Uuid для генерації унікальних ID

// Перелік можливих категорій витрат
enum Category { food, travel, leisure, work }

// Мапа, яка пов'язує кожну категорію з відповідною іконкою
const categoryIcons = {
  Category.food: Icons.lunch_dining, // Іконка для категорії "їжа"
  Category.travel: Icons.flight_takeoff, // Іконка для категорії "подорожі"
  Category.leisure: Icons.movie, // Іконка для категорії "дозвілля"
  Category.work: Icons.work, // Іконка для категорії "робота"
};

// Клас, що представляє окрему витрату
class Expense {
  Expense({
    required this.title, // Назва витрати
    required this.amount, // Сума витрати
    required this.date, // Дата витрати
    required this.category, // Категорія витрати
  }) : id =
           uuid.v4(); // При створенні об'єкта Expense генерується унікальний ID

  final String id; // Унікальний ідентифікатор витрати
  final String title; // Назва витрати
  final double amount; // Сума витрати
  final DateTime date; // Дата витрати
  final Category category; // Категорія витрати

  // Геттер для отримання форматованої дати витрати
  String get formattedDate {
    return formatter.format(
      date,
    ); // Форматування дати за допомогою об'єкта formatter
  }
}

// Клас, що представляє сумарні витрати за певною категорією
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  }); // Конструктор, що приймає категорію та список витрат

  // Іменований конструктор для створення ExpenseBucket на основі списку всіх витрат та конкретної категорії
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses =
          allExpenses
              .where((expense) => expense.category == category)
              .toList(); // Фільтрація витрат за вказаною категорією

  final Category category; // Категорія витрат у цьому "відрі"
  final List<Expense> expenses; // Список витрат, що належать до цієї категорії

  // Геттер для отримання загальної суми витрат у цьому "відрі"
  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // Додавання суми кожної витрати до загальної суми
    }

    return sum; // Повернення загальної суми витрат за категорією
  }
}
