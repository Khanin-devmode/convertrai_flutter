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

  void convertUnit(double newValue) {
    print('converting unit');
    switch (selectedUnit) {
      case ConvertingUnit.rai:
        {
          sqm = (newValue != null) ? newValue * 1600 : 0;
        }
        break;
      case ConvertingUnit.ngan:
        {
          sqm = (newValue != null) ? newValue * 400 : 0;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          sqm = (newValue != null) ? newValue * 4 : 0;
        }
        break;
      case ConvertingUnit.sqm:
        {
          sqm = (newValue != null) ? newValue : 0;
        }
        break;
      case ConvertingUnit.combined:
        {
          sqm = 0;
        }
        break;
    }

    totalSqWha = sqm / 4;
    rai = (totalSqWha / 400).floorToDouble();
    sqWaaRemainder = totalSqWha.remainder(400);
    ngan = (sqWaaRemainder / 100).floorToDouble();
    sqWha = sqWaaRemainder.remainder(100);

    fullRai = sqm / 1600;
    fullNgan = sqm / 400;
    fullSqWha = sqm / 4;

    print(sqm);
  }

  selectUnit(ConvertingUnit newUnit) {
    selectedUnit = newUnit;

    //calculate unit
    // convertUnit(currentValue);
  }
}

final calcProvider = Provider((ref) {
  return Calculation();
});

class CalNotifier extends StateNotifier<Calculation> {
  CalNotifier() : super(Calculation());

  void convertUnit(double newValue) {}
}
