enum ConvertingUnit { sqm, rai, ngan, sqWha, raiNganSqWha }

class Calculation {
  ConvertingUnit selectedUnit = ConvertingUnit.raiNganSqWha;

  double sqm = 1600;
  double rai = 1;
  double ngan = 0;
  double sqWha = 0;
  double fullRai = 1;
  double fullNgan = 4;
  double fullSqWha = 400;
  double sqWhaRemainder = 0;

  String getTextValueSelectedUnit(ConvertingUnit selectedUnit) {
    switch (selectedUnit) {
      case ConvertingUnit.rai:
        return '$rai';
      case ConvertingUnit.ngan:
        return '$ngan';
      case ConvertingUnit.sqWha:
        return '$sqWha.';
      case ConvertingUnit.sqm:
        return '$sqm';
      case ConvertingUnit.raiNganSqWha:
        return '0';
    }
  }
}
