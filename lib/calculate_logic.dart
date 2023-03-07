import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConvertingUnit { sqm, rai, ngan, sqWha, combined }

class Calculation {
  ConvertingUnit selectedUnit = ConvertingUnit.rai;

  double sqm = 1600;
  double rai = 1;
  double ngan = 0;
  double sqWha = 0;
  double fullRai = 1;
  double fullNgan = 4;
  double fullSqWha = 400;
  double totalSqWha = 0;
  double sqWaaRemainder = 0;
}

class CalNotifier extends StateNotifier<Calculation> {
  CalNotifier() : super(Calculation());

  void convertUnit(double newValue) {
    Calculation newCal = Calculation();

    switch (state.selectedUnit) {
      case ConvertingUnit.rai:
        {
          newCal.sqm = (newValue != null) ? newValue * 1600 : 0;
        }
        break;
      case ConvertingUnit.ngan:
        {
          newCal.sqm = (newValue != null) ? newValue * 400 : 0;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          newCal.sqm = (newValue != null) ? newValue * 4 : 0;
        }
        break;
      case ConvertingUnit.sqm:
        {
          newCal.sqm = (newValue != null) ? newValue : 0;
        }
        break;
      case ConvertingUnit.combined:
        {
          newCal.sqm = 0;
        }
        break;
    }

    newCal.totalSqWha = state.sqm / 4;
    newCal.rai = (newCal.totalSqWha / 400).floorToDouble();
    newCal.sqWaaRemainder = newCal.totalSqWha.remainder(400);
    newCal.ngan = (newCal.sqWaaRemainder / 100).floorToDouble();
    newCal.sqWha = newCal.sqWaaRemainder.remainder(100);

    newCal.fullRai = newCal.sqm / 1600;
    newCal.fullNgan = newCal.sqm / 400;
    newCal.fullSqWha = newCal.sqm / 4;

    state = newCal;
  }
}

final calNotifierProvider =
    StateNotifierProvider<CalNotifier, Calculation>((ref) {
  return CalNotifier();
});
