import 'package:convert_rai/features/main_page/presentation/main_app_state.dart';
import 'package:convert_rai/features/main_page/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // runApp(const ConverRaiApp());
  await Hive.initFlutter();

  runApp(const ProviderScope(child: ConverRaiApp()));
}

class ConverRaiApp extends ConsumerWidget {
  const ConverRaiApp({super.key});

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String localLangCode = ref.watch(localLangCodeProvider);

    return MaterialApp(
      title: 'Convert Rai',
      theme: ThemeData(
        fontFamily: 'Prompt',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('th'), // Thai
      ],
      locale: Locale(localLangCode),
      home: const MainPage(),
    );
  }
}
