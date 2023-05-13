import 'package:convert_rai/features/main_page/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        fontFamily: 'Prompt',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: const [
        Locale('en'), // English
        Locale('th'), // Thai
      ],
      home: const MainPage(),
    );
  }
}
