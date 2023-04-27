import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/price_converter/presentation/sections/price_output_section.dart';
import 'package:convert_rai/features/price_converter/presentation/sections/prince_input_section.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:convert_rai/shared_widgets/header_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceConverterPage extends ConsumerStatefulWidget {
  const PriceConverterPage({super.key});

  @override
  PriceConverterPageState createState() => PriceConverterPageState();
}

class PriceConverterPageState extends ConsumerState<PriceConverterPage> {
  final singleInputCtrl = TextEditingController(text: '1');
  final raiInputCtrl = TextEditingController(text: '1');
  final nganInputCtrl = TextEditingController();
  final sqWhaInputCtrl = TextEditingController();
  final priceInputCtrl = TextEditingController();

  ConvertingUnit seletedInputUnit = ConvertingUnit.rai;
  ConvertingUnit seletedOutputUnit = ConvertingUnit.rai;

  selectInputUnit(ConvertingUnit unit) {
    setState(() {
      seletedInputUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final priceCalState = ref.watch(priceCalNotifierProvider);
    final priceCalNotifier = ref.watch(priceCalNotifierProvider.notifier);
    // final outputText = kNumFormat.format(priceCalState).toString();

    onOutputUnitSelected(newUnit) {
      setState(() {
        seletedOutputUnit = newUnit;
      });

      var inputPrice = stringToDouble(priceInputCtrl.text);

      if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
        var unitValue = stringToDouble(singleInputCtrl.text);
        priceCalNotifier.convertPrice(inputPrice, unitValue, seletedInputUnit);
      } else {
        double rai = stringToDouble(raiInputCtrl.text);
        double ngan = stringToDouble(nganInputCtrl.text);
        double sqWha = stringToDouble(sqWhaInputCtrl.text);
        double inputPrice = stringToDouble(priceInputCtrl.text);
        priceCalNotifier.convertCombinedUnit(
            rai, ngan, sqWha, inputPrice, seletedOutputUnit);
      }
    }

    return Container(
      color: kBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderLabel(label: 'Price Converter'),
          PriceInputSection(
            seletedInputUnit: seletedInputUnit,
            singleInputCtrl: singleInputCtrl,
            priceInputCtrl: priceInputCtrl,
            priceCalNotifier: priceCalNotifier,
            seletedOutputUnit: seletedOutputUnit,
            raiInputCtrl: raiInputCtrl,
            nganInputCtrl: nganInputCtrl,
            sqWhaInputCtrl: sqWhaInputCtrl,
            selectInputUnit: selectInputUnit,
          ),
          Expanded(
            child: PriceOutputSection(
              headerLabel:
                  '${singleInputCtrl.text} ${getUnitText(seletedInputUnit)} = ${priceInputCtrl.text} บาท',
            ),
          ),
        ],
      ),
    );
  }
}
