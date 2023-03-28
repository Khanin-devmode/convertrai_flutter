import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:convert_rai/constants.dart';

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

String getInputText(TextEditingController inputControl, Calculation calState) {
  if (calState.selectedUnit == ConvertingUnit.raiNganSqWha) {
    return '${kNumFormat.format(stringToDouble(inputControl.text))} ไร่ ${kNumFormat.format(stringToDouble(inputControl.text))} งาน ${kNumFormat.format(stringToDouble(inputControl.text))} ตรว.';
  } else {
    return '${kNumFormat.format(stringToDouble(inputControl.text))} ${getUnitText(calState.selectedUnit)}';
  }
}
