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
}
