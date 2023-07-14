import 'package:expense_app/models/expense.dart';

class ExpenseBucket {
  final ExpenseCategory category;
  final List<Expense> expenses;

  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(
      {required List<Expense> allExpenses, required this.category})
      : expenses = allExpenses
            .where((element) => element.category == category ? true : false)
            .toList();
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
