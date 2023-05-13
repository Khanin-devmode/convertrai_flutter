import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {super.key,
      required this.inputTextController,
      required this.onChanged,
      required this.label});

  final TextEditingController inputTextController;
  final Function(String) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputTextController,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [],
      decoration: InputDecoration(
        // labelText: label,
        // hintText: label,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
