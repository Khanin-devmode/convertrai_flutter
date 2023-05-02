import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/domain/saving_logic.dart';
import 'package:convert_rai/shared_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultRow extends ConsumerWidget {
  const ResultRow({Key? key, required this.resultText, this.inputText})
      : super(key: key);

  final String resultText;
  final String? inputText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SaveNotifier saveNotifier = ref.watch(saveNotifierProvider.notifier);

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
                saveNotifier.saveResult('$inputText$resultText');
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.copy,
                color: kIconColor,
              ),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: '$inputText$resultText'));
                showSnackBar(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
