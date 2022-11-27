import 'package:flutter/material.dart';
import 'converter_page.dart';

void main() {
  runApp(const ConverRaiApp());
}

class ConverRaiApp extends StatelessWidget {
  const ConverRaiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convert Rai',
      theme: ThemeData(
        fontFamily: 'MontserratAlternates',
      ),
      home: const ConverterPage(),
    );
  }
}
