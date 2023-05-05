import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/data/price_output_model.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceOutputSection extends ConsumerWidget {
  const PriceOutputSection({super.key, required this.headerLabel});

  final String headerLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PriceOutput priceOutput = ref.watch(priceCalNotifierProvider);

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
            pricePerUnit: priceOutput.pricePerSqm,
            unit: 'ตรม.',
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerRai,
            unit: 'ไร่.',
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerNgan,
            unit: 'งาน.',
          ),
          PricePerUnitRow(
            pricePerUnit: priceOutput.pricePerSqWha,
            unit: 'ตรว.',
          ),
        ],
      ),
    );
  }
}

class PricePerUnitRow extends StatelessWidget {
  const PricePerUnitRow({
    super.key,
    required this.pricePerUnit,
    required this.unit,
  });

  final double pricePerUnit;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text('${kBahtFormat.format(pricePerUnit)} บาท / ${unit}'),
        ],
      ),
    );
  }
}
