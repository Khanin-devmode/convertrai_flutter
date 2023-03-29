import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/domain/calculate_logic.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';

class UnitSelectDropdown extends StatelessWidget {
  const UnitSelectDropdown(
      {super.key,
      required this.selectedUnit,
      required this.onChanged,
      required this.singleInputCtrl,
      required this.raiInputCtrl,
      required this.nganInputCtrl,
      required this.sqWhaInputCtrl});

  final ConvertingUnit selectedUnit;
  final Function(ConvertingUnit?) onChanged;
  final TextEditingController singleInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: DropdownButton<ConvertingUnit>(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          alignment: Alignment.center,
          value: selectedUnit,
          items: ConvertingUnit.values.map((ConvertingUnit unit) {
            return DropdownMenuItem<ConvertingUnit>(
                value: unit, child: Text(getUnitText(unit)));
          }).toList(),
          onChanged: onChanged
          // onChanged: (newUnit) {
          //   calNotifier.selectUnit(newUnit);

          //   if (newUnit != ConvertingUnit.raiNganSqWha) {
          //     double n = stringToDouble(singleInputCtrl.text);
          //     calNotifier.convertUnit(n);
          //   } else {
          //     double rai = stringToDouble(raiInputCtrl.text);
          //     double ngan = stringToDouble(nganInputCtrl.text);
          //     double sqWha = stringToDouble(sqWhaInputCtrl.text);
          //     calNotifier.convertCombinedUnit(rai, ngan, sqWha);
          //   }
          // },
          ),
    );
  }
}
