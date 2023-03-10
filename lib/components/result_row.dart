import 'package:convert_rai/components/snackbar.dart';
import 'package:convert_rai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({Key? key, required this.resultText}) : super(key: key);

  final String resultText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            // kNumFormat.format(resultText),
            resultText,
            style: kBodyText,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.save_outlined,
                color: kIconColor,
              ),
              onPressed: () async {
                //Save with notifier
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.copy,
                color: kIconColor,
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: resultText));
                showSnackBar(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
