import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}



class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
      familyMember: FamilyMember.father,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
      familyMember: FamilyMember.mother,
    ),
  ];

  // 🔽 Додано змінну для фільтрації за членом сім’ї
  FamilyMember? _selectedFamilyMember;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔽 Фільтрація витрат за членом сім’ї
    final filteredExpenses = _registeredExpenses.where((expense) {
      return _selectedFamilyMember == null ||
          expense.familyMember == _selectedFamilyMember;
    }).toList();

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (filteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: filteredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: filteredExpenses),
          // 🔽 Випадаючий список для вибору члена сім’ї
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButton<FamilyMember>(
              isExpanded: true,
              hint: const Text("Виберіть члена сім’ї"),
              value: _selectedFamilyMember,
              onChanged: (member) {
                setState(() {
                  _selectedFamilyMember = member;
                });
              },
              items: FamilyMember.values.map((member) {
                return DropdownMenuItem(
                  value: member,
                  child: Text(member.name),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
