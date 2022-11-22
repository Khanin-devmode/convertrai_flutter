import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kNumberInputFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
];

const kNumberKeyboardType = TextInputType.numberWithOptions(decimal: true);

const kBgColor = Color.fromARGB(255, 226, 226, 226);
const kTitleColor = Color.fromARGB(255, 44, 44, 44);
const kTitleTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTitleColor);
