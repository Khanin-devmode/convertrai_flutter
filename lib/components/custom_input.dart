import 'package:convert_rai/calculate_logic.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {super.key,
      required this.inputTextController,
      required this.calNotifier,
      required this.onChanged,
      required this.label});

  final TextEditingController inputTextController;
  final CalNotifier calNotifier;
  final Function(String) onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputTextController,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [ThousandsFormatter()],
      decoration: InputDecoration(
        // label: Text(label),
        hintText: label,
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
