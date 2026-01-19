import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UnitConverterState extends Equatable {
  final Calculation calculation;
  final TextEditingController singleInputCtrl;
  final TextEditingController raiInputCtrl;
  final TextEditingController nganInputCtrl;
  final TextEditingController sqWhaInputCtrl;

  const UnitConverterState({
    required this.calculation,
    required this.singleInputCtrl,
    required this.raiInputCtrl,
    required this.nganInputCtrl,
    required this.sqWhaInputCtrl,
  });

  factory UnitConverterState.initial() {
    return UnitConverterState(
      calculation: Calculation(),
      singleInputCtrl: TextEditingController(text: '1'),
      raiInputCtrl: TextEditingController(text: '1'),
      nganInputCtrl: TextEditingController(text: '0'),
      sqWhaInputCtrl: TextEditingController(text: '0'),
    );
  }

  UnitConverterState copyWith({
    Calculation? calculation,
    TextEditingController? singleInputCtrl,
    TextEditingController? raiInputCtrl,
    TextEditingController? nganInputCtrl,
    TextEditingController? sqWhaInputCtrl,
  }) {
    return UnitConverterState(
      calculation: calculation ?? this.calculation,
      singleInputCtrl: singleInputCtrl ?? this.singleInputCtrl,
      raiInputCtrl: raiInputCtrl ?? this.raiInputCtrl,
      nganInputCtrl: nganInputCtrl ?? this.nganInputCtrl,
      sqWhaInputCtrl: sqWhaInputCtrl ?? this.sqWhaInputCtrl,
    );
  }

  @override
  List<Object?> get props => [
        calculation,
        singleInputCtrl,
        raiInputCtrl,
        nganInputCtrl,
        sqWhaInputCtrl,
      ];
}
