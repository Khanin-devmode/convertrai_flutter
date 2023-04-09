import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';

class InputArea extends StatelessWidget {
  const InputArea({
    super.key,
    required this.calState,
    required this.singleInputCtrl,
    required this.calNotifier,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
  });

  final Calculation calState;
  final TextEditingController singleInputCtrl;
  final CalNotifier calNotifier;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: calState.selectedUnit != ConvertingUnit.raiNganSqWha
                ? CustomInputField(
                    label: getUnitText(calState.selectedUnit),
                    inputTextController: singleInputCtrl,
                    onChanged: (newValue) {
                      double n = stringToDouble(newValue);
                      calNotifier.convertUnit(n);
                    },
                  )
                : Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          label: 'ไร่',
                          inputTextController: raiInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(newValue);
                            double ngan = stringToDouble(nganInputCtrl.text);
                            double sqWha = stringToDouble(sqWhaInputCtrl.text);
                            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomInputField(
                          label: 'งาน',
                          inputTextController: nganInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(raiInputCtrl.text);
                            double ngan = stringToDouble(newValue);
                            double sqWha = stringToDouble(sqWhaInputCtrl.text);
                            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomInputField(
                          label: 'ตรว.',
                          inputTextController: sqWhaInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(raiInputCtrl.text);
                            double ngan = stringToDouble(nganInputCtrl.text);
                            double sqWha = stringToDouble(newValue);
                            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 2,
            child: UnitSelectDropdown(
              selectableUnits: const [
                ConvertingUnit.sqm,
                ConvertingUnit.rai,
                ConvertingUnit.ngan,
                ConvertingUnit.sqWha,
                ConvertingUnit.raiNganSqWha
              ],
              selectedUnit: calState.selectedUnit,
              onChanged: (newUnit) {
                calNotifier.selectUnit(newUnit);

                if (newUnit != ConvertingUnit.raiNganSqWha) {
                  double n = stringToDouble(singleInputCtrl.text);
                  calNotifier.convertUnit(n);
                } else {
                  double rai = stringToDouble(raiInputCtrl.text);
                  double ngan = stringToDouble(nganInputCtrl.text);
                  double sqWha = stringToDouble(sqWhaInputCtrl.text);
                  calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
