import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final kNumberInputFormatter = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
];

const kNumberKeyboardType = TextInputType.numberWithOptions(decimal: true);

const kBgColor = Color.fromARGB(255, 226, 226, 226);
const kTitleColor = Color.fromARGB(255, 44, 44, 44);
const kIconColor = Color.fromARGB(255, 100, 100, 100);
const kSnackBarBg = Color.fromARGB(226, 61, 61, 61);
const kTitleTextStyle =
    TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTitleColor);
const kSecondTitleTextStyle =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTitleColor);
const kBodyText = TextStyle(fontSize: 16);

var kNumFormat = NumberFormat(',###.######', 'en_US');
var kBahtFormat = NumberFormat(',###.##', 'en_US');
