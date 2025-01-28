import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.inputTextController,
    required this.onChanged,
    required this.label,
  });

  final TextEditingController inputTextController;
  final Function(String) onChanged;
  final String label;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.inputTextController,
      focusNode: focusNode,
      onChanged: widget.onChanged,
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d*\.?\d*')), // Allow numbers and a single '.'
      ],
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 12,
        ),
      ),
    );
  }
}
