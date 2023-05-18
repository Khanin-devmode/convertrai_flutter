import 'package:convert_rai/features/unit_converter/data/calculation_model.dart';
import 'package:flutter/material.dart';
import 'package:convert_rai/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

String getUnitText(ConvertingUnit unit, AppLocalizations appLocal) {
  switch (unit) {
    case ConvertingUnit.rai:
      return appLocal.rai;
    case ConvertingUnit.ngan:
      return appLocal.ngan;
    case ConvertingUnit.sqWha:
      return appLocal.sqWha;
    case ConvertingUnit.sqm:
      return appLocal.sqm;
    case ConvertingUnit.raiNganSqWha:
      return appLocal.raiNganSqWha;
  }
}

String getInputText(
    TextEditingController singleInputCtrl,
    TextEditingController raiInputCtrl,
    TextEditingController nganInputCtrl,
    TextEditingController sqWhaInputCtrl,
    ConvertingUnit selectedUnit,
    AppLocalizations appLocal) {
  if (selectedUnit == ConvertingUnit.raiNganSqWha) {
    return '${kNumFormat.format(stringToDouble(raiInputCtrl.text))} ไร่ ${kNumFormat.format(stringToDouble(nganInputCtrl.text))} งาน ${kNumFormat.format(stringToDouble(sqWhaInputCtrl.text))} ตรว.';
  } else {
    return '${kNumFormat.format(stringToDouble(singleInputCtrl.text))} ${getUnitText(selectedUnit, appLocal)}';
  }
}
