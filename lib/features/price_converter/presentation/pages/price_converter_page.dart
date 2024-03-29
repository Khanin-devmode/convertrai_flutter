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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderRow(label: 'Price Converter'),
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
                Text(
                  appLocal.pricePerUnit,
                  style: const TextStyle(fontSize: 20),
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
