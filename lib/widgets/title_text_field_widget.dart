import 'package:flutter/material.dart';

class TitleTextFieldWidget extends StatelessWidget {
  const TitleTextFieldWidget({
    Key? key,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      decoration: const InputDecoration(
        label: Text('title'),
      ),
    );
  }
}