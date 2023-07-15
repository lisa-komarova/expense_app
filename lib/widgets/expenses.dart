import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'title',
        amount: 1,
        date: DateTime.now(),
        category: ExpenseCategory.food),
    Expense(
        title: 'title1',
        amount: 1,
        date: DateTime.now(),
        category: ExpenseCategory.travel),
    Expense(
        title: 'title2',
        amount: 1,
        date: DateTime.now(),
        category: ExpenseCategory.food),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (ctx) => NewExpense(_addExpense));
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense app'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < height
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                    child: _registeredExpenses.isEmpty
                        ? const Center(child: Text('No expenses found'))
                        : ExpensesList(
                            expensesList: _registeredExpenses,
                            onRemoveExpense: _removeExpense,
                          ))
              ],
            )
          : Row(children: [
              Expanded(child: Chart(expenses: _registeredExpenses)),
              Expanded(
                  child: _registeredExpenses.isEmpty
                      ? const Center(child: Text('No expenses found'))
                      : ExpensesList(
                          expensesList: _registeredExpenses,
                          onRemoveExpense: _removeExpense,
                        ))
            ]),
    );
  }
}
