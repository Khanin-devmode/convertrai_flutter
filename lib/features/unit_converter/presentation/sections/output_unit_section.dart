import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/result_row.dart';
import 'package:flutter/material.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/constants.dart';

class OutputUnitSection extends StatelessWidget {
  const OutputUnitSection({
    super.key,
    required this.calState,
    required this.singleInputCtrl,
  });

  final Calculation calState;
  final TextEditingController singleInputCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          calState.selectedUnit != ConvertingUnit.raiNganSqWha
              ? ResultRow(
                  resultText:
                      '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.rai)} ไร่ ${kNumFormat.format(calState.ngan)} งาน ${kNumFormat.format(calState.sqWha)} ตรว.',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.sqm
              ? ResultRow(
                  resultText:
                      '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.sqm)} ตรม.',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.rai
              ? ResultRow(
                  resultText:
                      '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.fullRai)} ไร่.',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.ngan
              ? ResultRow(
                  resultText:
                      '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.fullNgan)} งาน.',
                )
              : const SizedBox(),
          calState.selectedUnit != ConvertingUnit.sqWha
              ? ResultRow(
                  resultText:
                      '${getInputText(singleInputCtrl, calState)} = ${kNumFormat.format(calState.fullSqWha)} ตรว.',
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
