import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final singleInputCtrlProviderUnitCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '1'));
final raiInputCtrlProviderUnitCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '1'));
final nganInputCtrlProviderUnitCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '0'));
final sqWhaInputCtrlProviderUnitCon = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: '0'));

final unitFormKeyPrivider = StateProvider<GlobalKey>((ref) => GlobalKey());

class CalNotifier extends StateNotifier<Calculation> {
  CalNotifier() : super(Calculation());

  void convertUnit(double newValue) {
    Calculation newCal = Calculation();

    newCal.selectedUnit = state.selectedUnit;

    switch (newCal.selectedUnit) {
      case ConvertingUnit.rai:
        {
          newCal.sqm = newValue * 1600;
        }
        break;
      case ConvertingUnit.ngan:
        {
          newCal.sqm = newValue * 400;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          newCal.sqm = newValue * 4;
        }
        break;
      case ConvertingUnit.sqm:
        {
          newCal.sqm = newValue;
        }
        break;
      case ConvertingUnit.raiNganSqWha:
        {
          newCal.sqm = newValue;
        }
        break;
      case ConvertingUnit.acre:
        {
          newCal.sqm = newValue * 4046.86;
        }
        break;
    }

    newCal.fullRai = newCal.sqm / 1600;
    newCal.fullNgan = newCal.sqm / 400;
    newCal.fullSqWha = newCal.sqm / 4;

    newCal.rai = (newCal.fullSqWha / 400).floorToDouble();
    newCal.sqWhaRemainder = newCal.fullSqWha.remainder(400);
    newCal.ngan = (newCal.sqWhaRemainder / 100).floorToDouble();
    newCal.sqWha = newCal.sqWhaRemainder.remainder(100);
    newCal.acre = newCal.sqm / 4046.86;

    state = newCal;
  }

  void convertCombinedUnit(double rai, double ngan, double sqWha) {
    double sqm = (rai * 1600) + (ngan * 400) + (sqWha * 4);

    convertUnit(sqm);
  }

  void selectUnit(newUnit) {
    Calculation newState = Calculation();

    //must find better solution, this is fine for this small project.
    newState.selectedUnit = newUnit;

    newState.sqm = state.sqm;
    newState.rai = state.rai;
    newState.ngan = state.ngan;
    newState.sqWha = state.sqWha;
    newState.fullRai = state.fullRai;
    newState.fullNgan = state.fullNgan;
    newState.fullSqWha = state.fullSqWha;
    newState.sqWhaRemainder = state.sqWhaRemainder;

    state = newState;
  }

  void resetState() {
    state = Calculation();
  }
}

final calNotifierProvider =
    StateNotifierProvider<CalNotifier, Calculation>((ref) {
  return CalNotifier();
});
