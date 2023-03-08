import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConvertingUnit { sqm, rai, ngan, sqWha, raiNganSqWha }

class Calculation {
  ConvertingUnit selectedUnit = ConvertingUnit.rai;

  double sqm = 1600;
  double rai = 1;
  double ngan = 0;
  double sqWha = 0;
  double fullRai = 1;
  double fullNgan = 4;
  double fullSqWha = 400;
  double sqWaaRemainder = 0;
}

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
          newCal.sqm = 0;
        }
        break;
    }

    newCal.fullRai = newCal.sqm / 1600;
    newCal.fullNgan = newCal.sqm / 400;
    newCal.fullSqWha = newCal.sqm / 4;

    newCal.fullSqWha = newCal.sqm / 4;
    newCal.rai = (newCal.fullSqWha / 400).floorToDouble();
    newCal.sqWaaRemainder = newCal.fullSqWha.remainder(400);
    newCal.ngan = (newCal.sqWaaRemainder / 100).floorToDouble();
    newCal.sqWha = newCal.sqWaaRemainder.remainder(100);

    state = newCal;
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
    newState.sqWaaRemainder = state.sqWaaRemainder;

    state = newState;
  }
}

final calNotifierProvider =
    StateNotifierProvider<CalNotifier, Calculation>((ref) {
  return CalNotifier();
});
