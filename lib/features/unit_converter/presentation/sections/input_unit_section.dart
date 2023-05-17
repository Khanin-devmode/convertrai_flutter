import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputSection extends StatelessWidget {
  const InputSection(
      {super.key,
      required this.calState,
      required this.singleInputCtrl,
      required this.calNotifier,
      required this.raiInputCtrl,
      required this.nganInputCtrl,
      required this.sqWhaInputCtrl,
      required this.appLocal});

  final Calculation calState;
  final TextEditingController singleInputCtrl;
  final CalNotifier calNotifier;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            appLocal.unit,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        UnitSelectDropdown(
          selectableUnits: const [
            ConvertingUnit.raiNganSqWha,
            ConvertingUnit.rai,
            ConvertingUnit.ngan,
            ConvertingUnit.sqWha,
            ConvertingUnit.sqm,
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
        calState.selectedUnit != ConvertingUnit.raiNganSqWha
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputLabel(label: 'ขนาดพื้นที่'),
                  CustomInputField(
                    label: getUnitText(calState.selectedUnit),
                    inputTextController: singleInputCtrl,
                    onChanged: (newValue) {
                      double n = stringToDouble(newValue);
                      calNotifier.convertUnit(n);
                    },
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InputLabel(label: 'ไร่'),
                        CustomInputField(
                          label: 'ไร่',
                          inputTextController: raiInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(newValue);
                            double ngan = stringToDouble(nganInputCtrl.text);
                            double sqWha = stringToDouble(sqWhaInputCtrl.text);
                            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InputLabel(label: 'งาน'),
                        CustomInputField(
                          label: 'งาน',
                          inputTextController: nganInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(raiInputCtrl.text);
                            double ngan = stringToDouble(newValue);
                            double sqWha = stringToDouble(sqWhaInputCtrl.text);
                            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InputLabel(label: 'ตรว.'),
                        CustomInputField(
                          label: 'ตรว.',
                          inputTextController: sqWhaInputCtrl,
                          onChanged: (newValue) {
                            double rai = stringToDouble(raiInputCtrl.text);
                            double ngan = stringToDouble(nganInputCtrl.text);
                            double sqWha = stringToDouble(newValue);
                            calNotifier.convertCombinedUnit(rai, ngan, sqWha);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
