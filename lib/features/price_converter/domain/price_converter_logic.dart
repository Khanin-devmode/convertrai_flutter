import 'package:convert_rai/features/price_converter/data/price_data_model.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceConverterCtrlsProvider =
    StateProvider<PriceConverterTextControllers>(
  (ref) => PriceConverterTextControllers(
    singleInput: TextEditingController(text: '1'),
    raiInput: TextEditingController(text: '1'),
    nganInput: TextEditingController(text: '0'),
    sqwaInput: TextEditingController(text: '0'),
    priceInput: TextEditingController(text: '0'),
    //
    singleOutput: TextEditingController(text: '1'),
    raiOutput: TextEditingController(text: '1'),
    nganOutput: TextEditingController(text: '0'),
    sqwaOutput: TextEditingController(text: '0'),
  ),
);

class PriceConverterTextControllers {
  PriceConverterTextControllers({
    required this.raiInput,
    required this.nganInput,
    required this.sqwaInput,
    required this.priceInput,
    required this.singleOutput,
    required this.raiOutput,
    required this.nganOutput,
    required this.sqwaOutput,
    required this.singleInput,
  });

  final TextEditingController singleInput;
  final TextEditingController raiInput;
  final TextEditingController nganInput;
  final TextEditingController sqwaInput;
  final TextEditingController priceInput;

  final TextEditingController singleOutput;
  final TextEditingController raiOutput;
  final TextEditingController nganOutput;
  final TextEditingController sqwaOutput;
}

class PriceCalNotifier extends StateNotifier<PriceData> {
  PriceCalNotifier()
      : super(
          PriceData(
            inputArea: 1,
            inputAreaUnit: ConvertingUnit.sqWa,
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
    state = PriceData(
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
    required double sqWa,
    double? inputPrice,
    double? outputArea,
    ConvertingUnit? outputAreaUnit,
  }) {
    double sqm = (rai * 1600) + (ngan * 400) + (sqWa * 4);

    updatePriceData(
      inputPrice: inputPrice,
      inputArea: sqm,
      inputAreaUnit: ConvertingUnit.sqm,
      outputArea: outputArea,
      outputAreaUnit: ConvertingUnit.sqm,
    );
  }
}

final priceCalNotifierProvider =
    StateNotifierProvider<PriceCalNotifier, PriceData>((ref) {
  return PriceCalNotifier();
});
