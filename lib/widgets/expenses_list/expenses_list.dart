import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expensesList;
  final Function(Expense expense) onRemoveExpense;
  const ExpensesList(
      {Key? key, required this.expensesList, required this.onRemoveExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expensesList[index]),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  Text('Delete', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          onDismissed: (direction) => onRemoveExpense(expensesList[index]),
          child: ExpenseItem(expense: expensesList[index])),
    );
  }
}
