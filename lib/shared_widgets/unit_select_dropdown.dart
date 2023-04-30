import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';

class UnitSelectDropdown extends StatelessWidget {
  const UnitSelectDropdown(
      {super.key,
      required this.selectedUnit,
      required this.onChanged,
      required this.selectableUnits});

  final ConvertingUnit selectedUnit;
  final Function(dynamic) onChanged;
  final List<ConvertingUnit> selectableUnits;

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
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            child: DropdownButton<ConvertingUnit>(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                alignment: Alignment.centerLeft,
                value: selectedUnit,
                items: selectableUnits.map((ConvertingUnit unit) {
                  return DropdownMenuItem<ConvertingUnit>(
                    value: unit,
                    child: Text(
                      getUnitText(unit),
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
