import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UnitSelectDropdown extends StatelessWidget {
  const UnitSelectDropdown(
      {super.key,
      required this.selectedUnit,
      required this.onChanged,
      required this.selectableUnits,
      required this.appLocal});

  final ConvertingUnit selectedUnit;
  final Function(dynamic) onChanged;
  final List<ConvertingUnit> selectableUnits;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: DropdownButton<ConvertingUnit>(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                alignment: Alignment.centerLeft,
                isExpanded: true,
                value: selectedUnit,
                items: selectableUnits.map((ConvertingUnit unit) {
                  return DropdownMenuItem<ConvertingUnit>(
                    value: unit,
                    child: Text(
                      getUnitText(unit, appLocal),
                    ),
                  );
                }).toList(),
                onChanged: onChanged),
          ),
        ),
      ],
    );
  }
}
