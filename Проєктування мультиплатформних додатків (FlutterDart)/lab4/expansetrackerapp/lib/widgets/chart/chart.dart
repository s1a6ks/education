import 'package:flutter/material.dart';
import '../../models/expense.dart';
import '../../models/expense_bucket.dart';
import 'chart_bar.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  bool _showByCategory = true; // true - показуємо по категоріях, false - по членах сім'ї

  List<ExpensesBucket> get buckets {
    return _showByCategory
        ? ExpensesBucket.forCategory(widget.expenses)
        : ExpensesBucket.forFamilyMembers(widget.expenses);
  }

  double get maxTotalExpense {
    return buckets.fold(0.0, (max, bucket) => bucket.totalExpenses > max ? bucket.totalExpenses : max);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Column(
      children: [
        // Перемикач між режимами
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Категорії'),
            Switch(
              value: !_showByCategory,
              onChanged: (value) {
                setState(() {
                  _showByCategory = !value;
                });
              },
            ),
            Text('Члени сім\'ї'),
          ],
        ),

        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withAlpha((.65 * 255).round()),
                Theme.of(context).colorScheme.primary.withAlpha(0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final bucket in buckets)
                      Expanded(
                        child: ChartBar(
                          fill: maxTotalExpense == 0 ? 0 : bucket.totalExpenses / maxTotalExpense,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Підписи текстом (без іконок)
              Row(
                children: buckets.map((bucket) {
                  final label = _showByCategory
                      ? bucket.category.toString().split('.').last
                      : bucket.familyMember.toString().split('.').last;

                  return Expanded(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary.withAlpha((0.7 * 255).round()),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
