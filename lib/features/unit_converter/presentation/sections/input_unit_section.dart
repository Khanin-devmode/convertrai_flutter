import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:convert_rai/shared_widgets/rai_ngan_sqwa_input.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputSection extends ConsumerWidget {
  const InputSection({
    super.key,
    required this.calState,
    required this.singleInputCtrl,
    required this.areaCalNotifier,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
    required this.appLocal,
  });

  final Calculation calState;
  final TextEditingController singleInputCtrl;
  final CalNotifier areaCalNotifier;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = ref.watch(unitFormKeyProvider);

    return Form(
      key: formKey,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: calState.selectedUnit != ConvertingUnit.raiNganSqWha
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputLabel(label: appLocal.areaSize),
                      CustomTextField(
                        label: getUnitText(calState.selectedUnit, appLocal),
                        inputTextController: singleInputCtrl,
                        onChanged: (newValue) {
                          double n = stringToDouble(newValue);
                          areaCalNotifier.convertUnit(n);
                        },
                      ),
                    ],
                  )
                : RaiNganSqwaTextFields(
                    appLocal: appLocal,
                    raiTextCtrl: raiInputCtrl,
                    nganTextCtrl: nganInputCtrl,
                    sqwaTextCtrl: sqWhaInputCtrl,
                    onChanged: (rai, ngan, sqwa) {
                      areaCalNotifier.convertCombinedUnit(rai, ngan, sqwa);
                    },
                  ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Column(
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
                    ConvertingUnit.sqWa,
                    ConvertingUnit.sqm,
                    ConvertingUnit.acre,
                  ],
                  appLocal: appLocal,
                  selectedUnit: calState.selectedUnit,
                  onChanged: (newUnit) {
                    areaCalNotifier.selectUnit(newUnit);

                    if (newUnit != ConvertingUnit.raiNganSqWha) {
                      double n = stringToDouble(singleInputCtrl.text);
                      areaCalNotifier.convertUnit(n);
                    } else {
                      double rai = stringToDouble(raiInputCtrl.text);
                      double ngan = stringToDouble(nganInputCtrl.text);
                      double sqWha = stringToDouble(sqWhaInputCtrl.text);
                      areaCalNotifier.convertCombinedUnit(rai, ngan, sqWha);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
