import 'package:convert_rai/features/main_page/presentation/main_page.dart';
import 'package:convert_rai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const ConvertRaiApp());
}

class ConvertRaiApp extends StatelessWidget {
  const ConvertRaiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // TODO: Will migrate language state to Bloc in Phase 5
    final String localLangCode = 'th';

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
