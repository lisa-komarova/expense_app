
import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
    required DateTime? selectedDate,
    required this.onPickingDate,
  })  : _selectedDate = selectedDate,
        super(key: key);

  final DateTime? _selectedDate;
  final void Function() onPickingDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(_selectedDate == null
            ? 'No date selected'
            : formatter.format(_selectedDate!)),
        IconButton(onPressed: onPickingDate, icon: const Icon(Icons.calendar_month))
      ],
    );
  }
}
