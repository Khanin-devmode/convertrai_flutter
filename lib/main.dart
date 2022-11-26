import 'package:flutter/material.dart';
import 'converter_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

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
