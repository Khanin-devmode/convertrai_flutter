import 'package:convert_rai/features/price_converter/data/price_data_model.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleInputCtrlProviderPriceCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '1'));
final raiInputCtrlProviderPriceCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '1'));
final nganInputCtrlProviderPriceCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '0'));
final sqWhaInputCtrlProviderPriceCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '0'));
final priceInputCtrlProviderPriceCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '0'));

class PriceCalNotifier extends StateNotifier<PriceData> {
  PriceCalNotifier()
      : super(
          PriceData(
            inputArea: 1,
            inputAreaUnit: ConvertingUnit.sqWha,
            inputPrice: 25000,
            outputArea: 1,
            outputAreaUnit: ConvertingUnit.rai,
          ),
        );

  void updatePriceData({
    double? inputPrice,
    double? inputArea,
    ConvertingUnit? inputAreaUnit,
    double? outputArea,
    ConvertingUnit? outputAreaUnit,
  }) {
    // switch (outputUnit) {
    //   case ConvertingUnit.rai:
    //     {
    //       state = pricerPerSqm / 0.000625;
    //     }
    //     break;
    //   case ConvertingUnit.ngan:
    //     {
    //       state = pricerPerSqm / 0.0025;
    //     }
    //     break;
    //   case ConvertingUnit.sqWha:
    //     {
    //       state = pricerPerSqm / 0.25;
    //     }
    //     break;
    //   case ConvertingUnit.sqm:
    //     {
    //       state = pricerPerSqm;
    //     }
    //     break;
    //   case ConvertingUnit.raiNganSqWha:
    //     {
    //       break;
    //     }
    // }

    state = PriceData(
      // pricePerRai: pricerPerSqm / 0.000625,
      // pricePerNgan: pricerPerSqm / 0.0025,
      // pricePerSqWha: pricerPerSqm / 0.25,
      // pricePerAcre: pricerPerSqm * 4046.86,
      inputArea: inputArea ?? state.inputArea,
      inputPrice: inputPrice ?? state.inputPrice,
      inputAreaUnit: inputAreaUnit ?? state.inputAreaUnit,
      outputArea: outputArea ?? state.outputArea,
      outputAreaUnit: outputAreaUnit ?? state.outputAreaUnit,
    );
  }

  void convertCombinedUnit({
    required double rai,
    required double ngan,
    required double sqWha,
    required double inputPrice,
    double? outputArea,
    ConvertingUnit? outputAreaUnit,
  }) {
    double sqm = (rai * 1600) + (ngan * 400) + (sqWha * 4);

    updatePriceData(
      inputPrice: inputPrice,
      inputArea: sqm,
      inputAreaUnit: ConvertingUnit.sqm,
      outputArea: outputArea,
      outputAreaUnit: outputAreaUnit,
    );
  }
}

final priceCalNotifierProvider =
    StateNotifierProvider<PriceCalNotifier, PriceData>((ref) {
  return PriceCalNotifier();
});
