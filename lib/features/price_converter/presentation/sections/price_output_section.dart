import 'package:convert_rai/constants.dart';
import 'package:convert_rai/features/price_converter/data/price_output_model.dart';
import 'package:convert_rai/features/price_converter/domain/price_converter_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceOutputSection extends ConsumerWidget {
  const PriceOutputSection({super.key, required this.headerLabel});

  final headerLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PriceOutput priceOutput = ref.watch(priceCalNotifierProvider);

    return Column(
      children: [
        Text(headerLabel),
        Text('ตรม. ละ ${kBahtFormat.format(priceOutput.pricePerSqm)} บาท'),
        Text('ไร่ ละ ${kBahtFormat.format(priceOutput.pricePerRai)} บาท'),
        Text('งาน ละ ${kBahtFormat.format(priceOutput.pricePerNgan)} บาท'),
        Text('ตรว. ละ ${kBahtFormat.format(priceOutput.pricePerSqWha)} บาท')
      ],
    );
  }
}
