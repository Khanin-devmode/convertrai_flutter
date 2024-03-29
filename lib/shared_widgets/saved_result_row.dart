import 'package:convert_rai/constants.dart';
import 'package:convert_rai/shared_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedResultRow extends StatelessWidget {
  const SavedResultRow({
    Key? key,
    required this.resultText,
    required this.deleteFunction,
    required this.index,
  }) : super(key: key);

  final String resultText;
  final Function(int) deleteFunction;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              resultText,
              style: kBodyText,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete_outlined,
                color: kIconColor,
              ),
              onPressed: () async {
                deleteFunction(index);
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
