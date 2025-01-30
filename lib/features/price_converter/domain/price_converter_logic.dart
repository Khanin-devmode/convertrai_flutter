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
    priceInput: TextEditingController(text: '25000'),
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
            inputSingleArea: 1,
            inputAreaUnit: ConvertingUnit.sqWa,
            inputPrice: 25000,
            inputRai: 1,
            inputNgan: 0,
            inputSqWa: 0,
            outputArea: 1,
            outputAreaUnit: ConvertingUnit.rai,
            outputRai: 1,
            outputNgan: 0,
            outputSqWa: 0,
          ),
        );

  void updatePriceData({
    double? inputPrice,
    double? inputSingleArea,
    double? inputRai,
    double? inputNgan,
    double? inputSqWa,
    ConvertingUnit? inputAreaUnit,
    double? outputSingleArea,
    double? outputRai,
    double? outputNgan,
    double? outputSqWa,
    ConvertingUnit? outputAreaUnit,
  }) {
    state = PriceData(
      inputSingleArea: inputSingleArea ?? state.inputSingleArea,
      inputPrice: inputPrice ?? state.inputPrice,
      inputAreaUnit: inputAreaUnit ?? state.inputAreaUnit,
      inputRai: inputRai ?? state.inputRai,
      inputNgan: inputNgan ?? state.inputNgan,
      inputSqWa: inputSqWa ?? state.inputSqWa,
      outputArea: outputSingleArea ?? state.outputArea,
      outputAreaUnit: outputAreaUnit ?? state.outputAreaUnit,
      outputRai: outputRai ?? state.outputRai,
      outputNgan: outputNgan ?? state.outputNgan,
      outputSqWa: outputSqWa ?? state.outputSqWa,
    );
  }

  // void convertCombinedInputUnit({
  //   required double rai,
  //   required double ngan,
  //   required double sqWa,
  //   double? inputPrice,
  //   ConvertingUnit? inputAreaUnit,
  //   double? outputArea,
  //   ConvertingUnit? outputAreaUnit,
  // }) {
  //   double sqm = (rai * 1600) + (ngan * 400) + (sqWa * 4);

  //   updatePriceData(
  //     inputSingleArea: sqm,
  //     inputAreaUnit: inputAreaUnit,
  //   );
  // }

  // void convertCombinedOutputUnit({
  //   required double rai,
  //   required double ngan,
  //   required double sqWa,
  //   // double? inputPrice,
  //   // ConvertingUnit? inputAreaUnit,
  //   // double? outputArea,
  //   ConvertingUnit? outputAreaUnit,
  // }) {
  //   double sqm = (rai * 1600) + (ngan * 400) + (sqWa * 4);

  //   updatePriceData(
  //     outputSingleArea: sqm,
  //     outputAreaUnit: outputAreaUnit,
  //   );
  // }
}

final priceCalNotifierProvider =
    StateNotifierProvider<PriceCalNotifier, PriceData>((ref) {
  return PriceCalNotifier();
});
