import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({
    super.key,
    required this.inputTextController,
    required this.onChanged,
    required this.label,
  });

  final TextEditingController inputTextController;
  final Function(String) onChanged;
  final String label;

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: super.key,
      controller: inputTextController,
      focusNode: focusNode,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: const [],
      onTapOutside: (event) {
        print(focusNode);
        focusNode.unfocus();
      },
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
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12)),
    );
  }
}
