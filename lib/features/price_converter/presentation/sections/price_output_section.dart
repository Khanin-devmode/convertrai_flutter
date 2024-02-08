import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/data/price_output_model.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:convert_rai/features/unit_converter/presentation/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceOutputSection extends ConsumerWidget {
  const PriceOutputSection(
      {super.key,
      required this.singleInputCtrl,
      required this.priceInputCtrl,
      required this.raiInputCtrl,
      required this.nganInputCtrl,
      required this.sqWhaInputCtrl,
      required this.selectedInputUnit,
      required this.appLocal});

  final TextEditingController singleInputCtrl;
  final TextEditingController priceInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final ConvertingUnit selectedInputUnit;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PriceOutput priceOutput = ref.watch(priceCalNotifierProvider);

    final inputText = getInputText(singleInputCtrl, raiInputCtrl, nganInputCtrl,
        sqWhaInputCtrl, selectedInputUnit, appLocal);

    final String headerLabel =
        '$inputText = ${priceInputCtrl.text} ${appLocal.baht}';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Text(
                headerLabel,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerRai,
            unit: appLocal.rai,
            appLocal: appLocal,
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerNgan,
            unit: appLocal.ngan,
            appLocal: appLocal,
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerSqWha,
            unit: appLocal.sqWha,
            appLocal: appLocal,
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerSqm,
            unit: appLocal.sqm,
            appLocal: appLocal,
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerAcre,
            unit: appLocal.acre,
            appLocal: appLocal,
          ),
        ],
      ),
    );
  }
}

class PricePerUnitRow extends StatelessWidget {
  const PricePerUnitRow(
      {super.key,
      required this.pricePerUnit,
      required this.unit,
      required this.appLocal});

  final double pricePerUnit;
  final String unit;
  final AppLocalizations appLocal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(
            kBahtFormat.format(pricePerUnit),
            style: kAccentBodyText,
          ),
          Text(
            ' ${appLocal.baht} / $unit',
            style: kBodyText,
          ),
        ],
      ),
    );
  }
}
