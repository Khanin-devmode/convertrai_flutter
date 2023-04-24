import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/data/price_output_model.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/unit_select_dropdown.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceOutputSection extends ConsumerWidget {
  const PriceOutputSection({
    super.key,
    required this.seletedOutputUnit,
    required this.onOutputUnitSelected,
  });

  final ConvertingUnit seletedOutputUnit;
  final Function(ConvertingUnit) onOutputUnitSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PriceOutput priceOutput = ref.watch(priceCalNotifierProvider);

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
        // Expanded(
        //   child: SizedBox(
        //     width: double.infinity,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           '${getUnitText(seletedOutputUnit)} ละ',
        //           style: kBodyText,
        //         ),
        //         Text(
        //           outputText,
        //           style: const TextStyle(fontSize: 48),
        //         ),
        //         const Text(
        //           'บาท',
        //           style: kBodyText,
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        Column(
          children: [
            Text('ตรม. ละ ${kBahtFormat.format(priceOutput.pricePerSqm)} บาท'),
            Text('ไร่ ละ ${kBahtFormat.format(priceOutput.pricePerRai)} บาท'),
            Text('งาน ละ ${kBahtFormat.format(priceOutput.pricePerNgan)} บาท'),
            Text(
                'ตรว. ละ ${kBahtFormat.format(priceOutput.pricePerSqWha)} บาท'),
          ],
        )
      ],
    );
  }
}
