import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/component_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';

class PriceOutputSection extends StatelessWidget {
  const PriceOutputSection({
    super.key,
    required this.seletedOutputUnit,
    required this.outputText,
    required this.onOutputUnitSelected,
  });

  final ConvertingUnit seletedOutputUnit;
  final String outputText;
  final Function(ConvertingUnit) onOutputUnitSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ราคาต่อหน่วย',
                style: TextStyle(fontSize: 18),
              ),
              Container(
                width: 120,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: UnitSelectDropdown(
                  selectableUnits: const [
                    ConvertingUnit.sqm,
                    ConvertingUnit.rai,
                    ConvertingUnit.ngan,
                    ConvertingUnit.sqWha,
                  ],
                  selectedUnit: seletedOutputUnit,
                  onChanged: (newUnit) => onOutputUnitSelected(newUnit),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${getUnitText(seletedOutputUnit)} ละ',
                  style: kBodyText,
                ),
                Text(
                  outputText,
                  style: TextStyle(fontSize: 48),
                ),
                const Text(
                  'บาท',
                  style: kBodyText,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
