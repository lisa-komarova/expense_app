
import 'package:flutter/material.dart';

class AmountTextFieldWidget extends StatelessWidget {
  const AmountTextFieldWidget({
    Key? key,
    required TextEditingController amountController,
  })  : _amountController = amountController,
        super(key: key);

  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      decoration: const InputDecoration(
        //prefixText: '\$',
        label: Text('amount, \$'),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
