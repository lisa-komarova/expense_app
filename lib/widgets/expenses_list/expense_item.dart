import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  expense.amount.toStringAsFixed(2) + "\$",
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(categoryItems[expense.category]),
                Text(expense.category.name),
                const Spacer(),
                Text(expense.formatedDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
