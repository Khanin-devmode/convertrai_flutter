import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/cubit/unit_converter_cubit.dart';
import 'package:convert_rai/shared_widgets/custom_input.dart';
import 'package:convert_rai/shared_widgets/input_label.dart';
import 'package:convert_rai/shared_widgets/rai_ngan_sqwa_input.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:convert_rai/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputSection extends StatelessWidget {
  const InputSection({
    super.key,
    required this.calState,
    required this.singleInputCtrl,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
    required this.appLocal,
  });

  final Calculation calState;
  final TextEditingController singleInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UnitConverterCubit>();

    return Row(
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
                          cubit.convertUnit(n);
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
                      cubit.convertCombinedUnit(rai, ngan, sqwa);
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
                    cubit.selectUnit(newUnit);

                    if (newUnit != ConvertingUnit.raiNganSqWha) {
                      double n = stringToDouble(singleInputCtrl.text);
                      cubit.convertUnit(n);
                    } else {
                      double rai = stringToDouble(raiInputCtrl.text);
                      double ngan = stringToDouble(nganInputCtrl.text);
                      double sqWha = stringToDouble(sqWhaInputCtrl.text);
                      cubit.convertCombinedUnit(rai, ngan, sqWha);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
    );
  }
}
