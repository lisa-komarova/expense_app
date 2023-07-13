import 'package:expense_app/models/expense.dart' as model;
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<model.Expense> _registeredExpenses = [
    model.Expense(
        title: 'title',
        amount: 1,
        date: DateTime.now(),
        category: model.Category.food),
    model.Expense(
        title: 'title1',
        amount: 1,
        date: DateTime.now(),
        category: model.Category.travel),
    model.Expense(
        title: 'title2',
        amount: 1,
        date: DateTime.now(),
        category: model.Category.food),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context, builder: (ctx) => NewExpense(_addExpense));
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted!'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text("chart"),
          Expanded(
              child: _registeredExpenses.isEmpty
                  ? const Center(child: Text('No expenses found'))
                  : ExpensesList(
                      expensesList: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ))
        ],
      ),
    );
  }
}