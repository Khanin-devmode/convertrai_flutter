import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/cubit/save_result_cubit.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/l10n/app_localizations.dart';
import 'package:convert_rai/shared_widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({
    Key? key,
    required this.valueList,
    required this.appLocal,
    this.inputText,
  }) : super(key: key);

  final String? inputText;
  final List<ValueUnitPair> valueList;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {

    String resultText = ' =';
    for (var pairValue in valueList) {
      resultText =
          '$resultText ${kNumFormat.format(pairValue.value)} ${getUnitText(pairValue.unit, appLocal)}';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: List.generate(
              valueList.length,
              (i) => RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(text: i == 0 ? '= ' : '', style: kBodyText),
                    TextSpan(
                        text: '${kNumFormat.format(valueList[i].value)} ',
                        style: kAccentBodyText),
                    TextSpan(
                        text: '${getUnitText(valueList[i].unit, appLocal)} ',
                        style: kBodyText),
                  ],
                ),
              ),
            ),
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
                //Save with cubit
                context.read<SaveResultCubit>().saveResult('$inputText$resultText');
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

class ValueUnitPair {
  ValueUnitPair({required this.value, required this.unit});
  double value;
  ConvertingUnit unit;
}
