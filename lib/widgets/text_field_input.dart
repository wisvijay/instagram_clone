import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hintText;
  final bool isPass;
  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.inputType,
      required this.hintText,
      this.isPass = false});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),
      ),
      obscureText: isPass,
    );
  }
}
