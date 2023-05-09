import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/result_row.dart';
import 'package:flutter/material.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/constants.dart';

class OutputUnitSection extends StatelessWidget {
  const OutputUnitSection(
      {super.key,
      required this.calState,
      required this.singleInputCtrl,
      required this.raiInputCtrl,
      required this.nganInputCtrl,
      required this.sqWhaInputCtrl});

  final Calculation calState;
  final TextEditingController singleInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;

  @override
  Widget build(BuildContext context) {
    final inputText = getInputText(
        singleInputCtrl, raiInputCtrl, nganInputCtrl, sqWhaInputCtrl, calState);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Text(
                inputText,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          calState.selectedUnit != ConvertingUnit.raiNganSqWha
              ? ResultRow(
                  inputText: inputText,
                  valueList: [
                    ValueUnitPair(
                        value: calState.rai, unit: ConvertingUnit.rai),
                    ValueUnitPair(
                        value: calState.ngan, unit: ConvertingUnit.ngan),
                    ValueUnitPair(
                        value: calState.sqWha, unit: ConvertingUnit.sqWha),
                  ],
                  // resultValue:
                  //     ' = ${kNumFormat.format(calState.rai)} ไร่ ${kNumFormat.format(calState.ngan)} งาน ${kNumFormat.format(calState.sqWha)} ตรว.',
                  // resultUnit: '',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.rai
              ? ResultRow(
                  inputText: inputText,
                  valueList: [
                    ValueUnitPair(
                        value: calState.fullRai, unit: ConvertingUnit.rai)
                  ],
                  // resultValue: ' = ${kNumFormat.format(calState.fullRai)} ไร่.',
                  // resultUnit: '',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.ngan
              ? ResultRow(
                  inputText: inputText,
                  valueList: [
                    ValueUnitPair(
                        value: calState.fullNgan, unit: ConvertingUnit.ngan)
                  ],
                  // resultValue:
                  //     ' = ${kNumFormat.format(calState.fullNgan)} งาน.',
                  // resultUnit: '',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.sqWha
              ? ResultRow(
                  inputText: inputText,
                  valueList: [
                    ValueUnitPair(
                        value: calState.fullSqWha, unit: ConvertingUnit.sqWha)
                  ],
                  // resultValue:
                  //     ' = ${kNumFormat.format(calState.fullSqWha)} ตรว.',
                  // resultUnit: '',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.sqm
              ? ResultRow(
                  inputText: inputText,
                  valueList: [
                    ValueUnitPair(value: calState.sqm, unit: ConvertingUnit.sqm)
                  ],
                  // resultValue: ' = ${kNumFormat.format(calState.sqm)} ตรม.',
                  // resultUnit: '',
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
