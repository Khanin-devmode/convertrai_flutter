import 'package:convert_rai/features/price_converter/data/price_data_model.dart';
import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PriceConverterState extends Equatable {
  final PriceData priceData;
  final TextEditingController singleInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;
  final TextEditingController priceInputCtrl;
  final TextEditingController singleOutputCtrl;
  final TextEditingController raiOutputCtrl;
  final TextEditingController nganOutputCtrl;
  final TextEditingController sqWhaOutputCtrl;

  const PriceConverterState({
    required this.priceData,
    required this.singleInputCtrl,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
    required this.priceInputCtrl,
    required this.singleOutputCtrl,
    required this.raiOutputCtrl,
    required this.nganOutputCtrl,
    required this.sqWhaOutputCtrl,
  });

  factory PriceConverterState.initial() {
    return PriceConverterState(
      priceData: PriceData(
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
      singleInputCtrl: TextEditingController(text: '1'),
      raiInputCtrl: TextEditingController(text: '1'),
      nganInputCtrl: TextEditingController(text: '0'),
      sqWhaInputCtrl: TextEditingController(text: '0'),
      priceInputCtrl: TextEditingController(text: '25000'),
      singleOutputCtrl: TextEditingController(text: '1'),
      raiOutputCtrl: TextEditingController(text: '1'),
      nganOutputCtrl: TextEditingController(text: '0'),
      sqWhaOutputCtrl: TextEditingController(text: '0'),
    );
  }

  PriceConverterState copyWith({
    PriceData? priceData,
    TextEditingController? singleInputCtrl,
    TextEditingController? raiInputCtrl,
    TextEditingController? nganInputCtrl,
    TextEditingController? sqWhaInputCtrl,
    TextEditingController? priceInputCtrl,
    TextEditingController? singleOutputCtrl,
    TextEditingController? raiOutputCtrl,
    TextEditingController? nganOutputCtrl,
    TextEditingController? sqWhaOutputCtrl,
  }) {
    return PriceConverterState(
      priceData: priceData ?? this.priceData,
      singleInputCtrl: singleInputCtrl ?? this.singleInputCtrl,
      raiInputCtrl: raiInputCtrl ?? this.raiInputCtrl,
      nganInputCtrl: nganInputCtrl ?? this.nganInputCtrl,
      sqWhaInputCtrl: sqWhaInputCtrl ?? this.sqWhaInputCtrl,
      priceInputCtrl: priceInputCtrl ?? this.priceInputCtrl,
      singleOutputCtrl: singleOutputCtrl ?? this.singleOutputCtrl,
      raiOutputCtrl: raiOutputCtrl ?? this.raiOutputCtrl,
      nganOutputCtrl: nganOutputCtrl ?? this.nganOutputCtrl,
      sqWhaOutputCtrl: sqWhaOutputCtrl ?? this.sqWhaOutputCtrl,
    );
  }

  @override
  List<Object?> get props => [
        priceData,
        singleInputCtrl,
        raiInputCtrl,
        nganInputCtrl,
        sqWhaInputCtrl,
        priceInputCtrl,
        singleOutputCtrl,
        raiOutputCtrl,
        nganOutputCtrl,
        sqWhaOutputCtrl,
      ];
}
