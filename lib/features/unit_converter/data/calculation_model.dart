enum ConvertingUnit { sqm, rai, ngan, sqWa, raiNganSqWha, acre, hectare, sqKm, sqFt }

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
  double acre = 0.39536826;
  double hectare = 0.16;
  double sqKm = 0.0016;
  double sqFt = 17222.256;

  String getTextValueSelectedUnit(ConvertingUnit selectedUnit) {
    switch (selectedUnit) {
      case ConvertingUnit.rai:
        return '$rai';
      case ConvertingUnit.ngan:
        return '$ngan';
      case ConvertingUnit.sqWa:
        return '$sqWha.';
      case ConvertingUnit.sqm:
        return '$sqm';
      case ConvertingUnit.raiNganSqWha:
        return '0';
      case ConvertingUnit.acre:
        return '$acre';
      case ConvertingUnit.hectare:
        return '$hectare';
      case ConvertingUnit.sqKm:
        return '$sqKm';
      case ConvertingUnit.sqFt:
        return '$sqFt';
    }
  }
}
