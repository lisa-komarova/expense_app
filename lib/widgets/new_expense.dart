import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/amount_text_field_widget.dart';
import 'package:expense_app/widgets/date_picker_widget.dart';
import 'package:expense_app/widgets/title_text_field_widget.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense expense) onSaveExpense;
  const NewExpense(
    this.onSaveExpense, {
    Key? key,
  }) : super(key: key);
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.leisure;
  void _presentDatePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year - 1, now.month, now.day);
    var lastDate = DateTime(now.year + 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpensesData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_textController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: ((context) => SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AlertDialog(
                  title: const Text('Invalid input'),
                  content: const Text(
                      'Please make sure a valid title,amount and date were entered'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay'),
                    )
                  ],
                ),
              )));
      return;
    }
    widget.onSaveExpense(Expense(
      title: _textController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: ((context, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, keyboardSpace + 8),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TitleTextFieldWidget(
                              textController: _textController)),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: AmountTextFieldWidget(
                            amountController: _amountController),
                      ),
                    ],
                  )
                else
                  TitleTextFieldWidget(textController: _textController),
                if (width < 600)
                  Row(
                    children: [
                      Expanded(
                        child: AmountTextFieldWidget(
                            amountController: _amountController),
                      ),
                      Expanded(
                          child: DatePickerWidget(
                        selectedDate: _selectedDate,
                        onPickingDate: _presentDatePicker,
                      ))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: ExpenseCategory.values
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name.toString())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value as ExpenseCategory;
                            });
                          }),
                      Expanded(
                          child: DatePickerWidget(
                        selectedDate: _selectedDate,
                        onPickingDate: _presentDatePicker,
                      ))
                    ],
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (width < 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: ExpenseCategory.values
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.name.toString())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value as ExpenseCategory;
                            });
                          }),
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          onPressed: _submitExpensesData,
                          child: const Text("Save expense"))
                    ],
                  )
                else
                  Row(
                    children: [
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                          onPressed: _submitExpensesData,
                          child: const Text("Save expense"))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
