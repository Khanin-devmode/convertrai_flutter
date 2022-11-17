import 'package:flutter/services.dart';

final kNumberInputFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
];

const kNumberKeyboardType = TextInputType.numberWithOptions(decimal: true);
