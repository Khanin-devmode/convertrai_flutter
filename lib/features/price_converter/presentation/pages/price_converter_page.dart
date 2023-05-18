import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/price_converter/presentation/sections/price_output_section.dart';
import 'package:convert_rai/features/price_converter/presentation/sections/price_input_section.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/shared_widgets/header_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceConverterPage extends ConsumerStatefulWidget {
  const PriceConverterPage({super.key});

  @override
  PriceConverterPageState createState() => PriceConverterPageState();
}

class PriceConverterPageState extends ConsumerState<PriceConverterPage> {
  // final singleInputCtrl = TextEditingController(text: '1');
  // final raiInputCtrl = TextEditingController(text: '1');
  // final nganInputCtrl = TextEditingController(text: '0');
  // final sqWhaInputCtrl = TextEditingController(text: '0');
  // final priceInputCtrl = TextEditingController(text: '0');

  ConvertingUnit seletedInputUnit = ConvertingUnit.sqWha;
  ConvertingUnit seletedOutputUnit = ConvertingUnit.rai;

  selectInputUnit(ConvertingUnit unit) {
    setState(() {
      seletedInputUnit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final priceCalNotifier = ref.watch(priceCalNotifierProvider.notifier);
    // final outputText = kNumFormat.format(priceCalState).toString();
    final singleInputCtrl = ref.watch(singleInputCtrlProviderPriceCon);
    final raiInputCtrl = ref.watch(raiInputCtrlProviderPriceCon);
    final nganInputCtrl = ref.watch(nganInputCtrlProviderPriceCon);
    final sqWhaInputCtrl = ref.watch(sqWhaInputCtrlProviderPriceCon);
    final priceInputCtrl = ref.watch(priceInputCtrlProviderPriceCon);

    final appLocal = AppLocalizations.of(context)!;

    // onOutputUnitSelected(newUnit) {
    //   setState(() {
    //     seletedOutputUnit = newUnit;
    //   });

    //   var inputPrice = stringToDouble(priceInputCtrl.text);

    //   if (seletedInputUnit != ConvertingUnit.raiNganSqWha) {
    //     var unitValue = stringToDouble(singleInputCtrl.text);
    //     priceCalNotifier.convertPrice(inputPrice, unitValue, seletedInputUnit);
    //   } else {
    //     double rai = stringToDouble(raiInputCtrl.text);
    //     double ngan = stringToDouble(nganInputCtrl.text);
    //     double sqWha = stringToDouble(sqWhaInputCtrl.text);
    //     double inputPrice = stringToDouble(priceInputCtrl.text);
    //     priceCalNotifier.convertCombinedUnit(
    //         rai, ngan, sqWha, inputPrice, seletedOutputUnit);
    //   }
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderLabel(label: 'Price Converter'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding:
                const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
            decoration: const BoxDecoration(
              color: Color(
                0xFFF6F5F1,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
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
                  appLocal: appLocal,
                ),
                const Divider(
                  height: 40,
                ),
                const Text(
                  'ราคาต่อหน่วย',
                  style: TextStyle(fontSize: 20),
                ),
                PriceOutputSection(
                  singleInputCtrl: singleInputCtrl,
                  raiInputCtrl: raiInputCtrl,
                  nganInputCtrl: nganInputCtrl,
                  sqWhaInputCtrl: sqWhaInputCtrl,
                  priceInputCtrl: priceInputCtrl,
                  selectedInputUnit: seletedInputUnit,
                  appLocal: appLocal,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        )
      ],
    );
  }
}
