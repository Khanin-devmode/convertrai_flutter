import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConvertingUnit { sqm, rai, ngan, sqWha, combined }

class Calculation {
  ConvertingUnit selectedUnit = ConvertingUnit.sqm;

  double _sqm = 1600;
  double _rai = 1;
  double _ngan = 0;
  double _sqWha = 0;
  double _fullRai = 1;
  double _fullNgan = 4;
  double _fullSqWha = 400;
  double _totalSqWha = 0;
  double sqWaaRemainder = 0;

  void convertUnit(ConvertingUnit inputUnit, double newValue) {
    switch (selectedUnit) {
      case ConvertingUnit.rai:
        {
          _sqm = (newValue != null) ? newValue * 1600 : 0;
        }
        break;
      case ConvertingUnit.ngan:
        {
          _sqm = (newValue != null) ? newValue * 400 : 0;
        }
        break;
      case ConvertingUnit.sqWha:
        {
          _sqm = (newValue != null) ? newValue * 4 : 0;
        }
        break;
      case ConvertingUnit.sqm:
        {
          _sqm = (newValue != null) ? newValue : 0;
        }
        break;
      case ConvertingUnit.combined:
        {
          _sqm = 0;
        }
        break;
    }

    _totalSqWha = _sqm / 4;
    _rai = (_totalSqWha / 400).floorToDouble();
    sqWaaRemainder = _totalSqWha.remainder(400);
    _ngan = (sqWaaRemainder / 100).floorToDouble();
    _sqWha = sqWaaRemainder.remainder(100);

    _fullRai = _sqm / 1600;
    _fullNgan = _sqm / 400;
    _fullSqWha = _sqm / 4;
  }
}

final calcProvider = Provider((ref) {
  return Calculation();
});
