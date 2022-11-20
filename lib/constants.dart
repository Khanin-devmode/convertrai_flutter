import 'package:flutter/services.dart';

final kNumberInputFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
];

const kNumberKeyboardType = TextInputType.numberWithOptions(decimal: true);

const kBgColor = Color.fromARGB(255, 235, 235, 235);
