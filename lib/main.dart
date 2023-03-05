import 'package:convert_rai/pages/new_converter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/converter_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  // runApp(const ConverRaiApp());

  runApp(const ProviderScope(child: ConverRaiApp()));
}

class ConverRaiApp extends StatelessWidget {
  const ConverRaiApp({super.key});

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convert Rai',
      theme: ThemeData(
        fontFamily: 'MontserratAlternates',
        useMaterial3: true,
      ),
      home: const NewConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
