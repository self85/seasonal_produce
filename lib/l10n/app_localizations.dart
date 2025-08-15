import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_sv.dart';

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
    Locale('es'),
    Locale('sv')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'IN SEASON'**
  String get appTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get language;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'LOCATION'**
  String get location;

  /// No description provided for @sweden.
  ///
  /// In en, this message translates to:
  /// **'Sweden'**
  String get sweden;

  /// No description provided for @andalucia.
  ///
  /// In en, this message translates to:
  /// **'Andalucia'**
  String get andalucia;

  /// No description provided for @swedish.
  ///
  /// In en, this message translates to:
  /// **'Swedish'**
  String get swedish;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @apples.
  ///
  /// In en, this message translates to:
  /// **'Apples'**
  String get apples;

  /// No description provided for @strawberries.
  ///
  /// In en, this message translates to:
  /// **'Strawberries'**
  String get strawberries;

  /// No description provided for @blueberries.
  ///
  /// In en, this message translates to:
  /// **'Blueberries'**
  String get blueberries;

  /// No description provided for @raspberries.
  ///
  /// In en, this message translates to:
  /// **'Raspberries'**
  String get raspberries;

  /// No description provided for @mushrooms.
  ///
  /// In en, this message translates to:
  /// **'Mushrooms'**
  String get mushrooms;

  /// No description provided for @grapes.
  ///
  /// In en, this message translates to:
  /// **'Grapes'**
  String get grapes;

  /// No description provided for @pears.
  ///
  /// In en, this message translates to:
  /// **'Pears'**
  String get pears;

  /// No description provided for @plums.
  ///
  /// In en, this message translates to:
  /// **'Plums'**
  String get plums;

  /// No description provided for @cherries.
  ///
  /// In en, this message translates to:
  /// **'Cherries'**
  String get cherries;

  /// No description provided for @beets.
  ///
  /// In en, this message translates to:
  /// **'Beets'**
  String get beets;

  /// No description provided for @potatoes.
  ///
  /// In en, this message translates to:
  /// **'Potatoes'**
  String get potatoes;

  /// No description provided for @carrots.
  ///
  /// In en, this message translates to:
  /// **'Carrots'**
  String get carrots;

  /// No description provided for @broccoli.
  ///
  /// In en, this message translates to:
  /// **'Broccoli'**
  String get broccoli;

  /// No description provided for @cauliflower.
  ///
  /// In en, this message translates to:
  /// **'Cauliflower'**
  String get cauliflower;

  /// No description provided for @peas.
  ///
  /// In en, this message translates to:
  /// **'Peas'**
  String get peas;

  /// No description provided for @cabbage.
  ///
  /// In en, this message translates to:
  /// **'Cabbage'**
  String get cabbage;

  /// No description provided for @kale.
  ///
  /// In en, this message translates to:
  /// **'Kale'**
  String get kale;

  /// No description provided for @brusselsSprouts.
  ///
  /// In en, this message translates to:
  /// **'Brussels Sprouts'**
  String get brusselsSprouts;

  /// No description provided for @papaya.
  ///
  /// In en, this message translates to:
  /// **'Papaya'**
  String get papaya;

  /// No description provided for @pineapple.
  ///
  /// In en, this message translates to:
  /// **'Pineapple'**
  String get pineapple;

  /// No description provided for @mango.
  ///
  /// In en, this message translates to:
  /// **'Mango'**
  String get mango;

  /// No description provided for @passionfruit.
  ///
  /// In en, this message translates to:
  /// **'Passionfruit'**
  String get passionfruit;

  /// No description provided for @kiwi.
  ///
  /// In en, this message translates to:
  /// **'Kiwi'**
  String get kiwi;

  /// No description provided for @lychee.
  ///
  /// In en, this message translates to:
  /// **'Lychee'**
  String get lychee;

  /// No description provided for @pomegranate.
  ///
  /// In en, this message translates to:
  /// **'Pomegranate'**
  String get pomegranate;

  /// No description provided for @coconut.
  ///
  /// In en, this message translates to:
  /// **'Coconut'**
  String get coconut;

  /// No description provided for @avocado.
  ///
  /// In en, this message translates to:
  /// **'Avocado'**
  String get avocado;

  /// No description provided for @oranges.
  ///
  /// In en, this message translates to:
  /// **'Oranges'**
  String get oranges;

  /// No description provided for @lemons.
  ///
  /// In en, this message translates to:
  /// **'Lemons'**
  String get lemons;

  /// No description provided for @olives.
  ///
  /// In en, this message translates to:
  /// **'Olives'**
  String get olives;

  /// No description provided for @almonds.
  ///
  /// In en, this message translates to:
  /// **'Almonds'**
  String get almonds;

  /// No description provided for @figs.
  ///
  /// In en, this message translates to:
  /// **'Figs'**
  String get figs;

  /// No description provided for @lingonberries.
  ///
  /// In en, this message translates to:
  /// **'Lingonberries'**
  String get lingonberries;

  /// No description provided for @cloudberries.
  ///
  /// In en, this message translates to:
  /// **'Cloudberries'**
  String get cloudberries;

  /// No description provided for @rhubarb.
  ///
  /// In en, this message translates to:
  /// **'Rhubarb'**
  String get rhubarb;

  /// No description provided for @cranberries.
  ///
  /// In en, this message translates to:
  /// **'Cranberries'**
  String get cranberries;

  /// No description provided for @blackcurrants.
  ///
  /// In en, this message translates to:
  /// **'Blackcurrants'**
  String get blackcurrants;
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
      <String>['en', 'es', 'sv'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'sv':
      return AppLocalizationsSv();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
