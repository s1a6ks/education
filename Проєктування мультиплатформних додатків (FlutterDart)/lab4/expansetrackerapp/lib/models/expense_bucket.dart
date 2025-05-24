import 'expense.dart';

class ExpensesBucket {
  final FamilyMember? familyMember;
  final Category? category;
  final double totalExpenses;

  ExpensesBucket({
    this.familyMember,
    this.category,
    required this.totalExpenses,
  });

  static List<ExpensesBucket> forCategory(List<Expense> expenses) {
    return Category.values.map((category) {
      final total = expenses
          .where((expense) => expense.category == category)
          .fold(0.0, (sum, e) => sum + e.amount);
      return ExpensesBucket(category: category, totalExpenses: total);
    }).toList();
  }

  static List<ExpensesBucket> forFamilyMembers(List<Expense> expenses) {
    return FamilyMember.values.map((member) {
      final total = expenses
          .where((expense) => expense.familyMember == member)
          .fold(0.0, (sum, e) => sum + e.amount);
      return ExpensesBucket(familyMember: member, totalExpenses: total);
    }).toList();
  }
}
