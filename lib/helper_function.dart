import 'package:convert_rai/calculate_logic.dart';

double stringToDouble(String newValue) {
  String pureNum = newValue.replaceAll(RegExp('[^A-Za-z0-9]'), '');
  double n;
  if (pureNum.isNotEmpty) {
    n = double.parse(pureNum);
  } else {
    n = 0;
  }
  return n;
}

String getUnitText(ConvertingUnit unit) {
  switch (unit) {
    case ConvertingUnit.rai:
      return 'ไร่';
    case ConvertingUnit.ngan:
      return 'งาน';
    case ConvertingUnit.sqWha:
      return 'ตรว.';
    case ConvertingUnit.sqm:
      return 'ตรม.';
    case ConvertingUnit.raiNganSqWha:
      return 'ไร่/งาน/ตรว.';
  }
}
