import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th')
  ];

  /// The conventional newborn programmer greeting
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @rai.
  ///
  /// In en, this message translates to:
  /// **'Rai'**
  String get rai;

  /// No description provided for @ngan.
  ///
  /// In en, this message translates to:
  /// **'Ngan'**
  String get ngan;

  /// No description provided for @sqWa.
  ///
  /// In en, this message translates to:
  /// **'SqWa.'**
  String get sqWa;

  /// No description provided for @sqm.
  ///
  /// In en, this message translates to:
  /// **'Sqm.'**
  String get sqm;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @raiNganSqWha.
  ///
  /// In en, this message translates to:
  /// **'R/N/W'**
  String get raiNganSqWha;

  /// No description provided for @conversion.
  ///
  /// In en, this message translates to:
  /// **'Conversion'**
  String get conversion;

  /// No description provided for @saveResult.
  ///
  /// In en, this message translates to:
  /// **'Save Results'**
  String get saveResult;

  /// No description provided for @press.
  ///
  /// In en, this message translates to:
  /// **'Press'**
  String get press;

  /// No description provided for @saveResultHere.
  ///
  /// In en, this message translates to:
  /// **'to save results here.'**
  String get saveResultHere;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @pricePerUnit.
  ///
  /// In en, this message translates to:
  /// **'Price per unit'**
  String get pricePerUnit;

  /// No description provided for @baht.
  ///
  /// In en, this message translates to:
  /// **'Baht'**
  String get baht;

  /// No description provided for @areaSize.
  ///
  /// In en, this message translates to:
  /// **'Area Size'**
  String get areaSize;

  /// No description provided for @acre.
  ///
  /// In en, this message translates to:
  /// **'Acre'**
  String get acre;

  /// No description provided for @areaUnitConverter.
  ///
  /// In en, this message translates to:
  /// **'Unit Converter'**
  String get areaUnitConverter;

  /// No description provided for @areaPriceConverter.
  ///
  /// In en, this message translates to:
  /// **'​Price Converter'**
  String get areaPriceConverter;

  /// No description provided for @startingAreaPrice.
  ///
  /// In en, this message translates to:
  /// **'Starting Area Price'**
  String get startingAreaPrice;

  /// No description provided for @targetAreaPrice.
  ///
  /// In en, this message translates to:
  /// **'Target Area Price'**
  String get targetAreaPrice;

  /// No description provided for @inputArea.
  ///
  /// In en, this message translates to:
  /// **'Input Area'**
  String get inputArea;

  /// No description provided for @allResult.
  ///
  /// In en, this message translates to:
  /// **'All Results'**
  String get allResult;

  /// No description provided for @unitCoverter.
  ///
  /// In en, this message translates to:
  /// **'Unit Converter'**
  String get unitCoverter;

  /// No description provided for @priceConverter.
  ///
  /// In en, this message translates to:
  /// **'Price Converter'**
  String get priceConverter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
