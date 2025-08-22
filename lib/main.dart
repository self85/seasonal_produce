// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:seasonal_produce/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/produce_list_page.dart';

const String kLocaleLanguageKey = 'locale_language';

void main() => runApp(const InSeasonApp());

class InSeasonApp extends StatefulWidget {
  const InSeasonApp({super.key});

  @override
  InSeasonAppState createState() => InSeasonAppState();
}

class InSeasonAppState extends State<InSeasonApp> {
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String savedLanguage = prefs.getString(kLocaleLanguageKey) ?? 'en';
    setState(() {
      _locale = Locale(savedLanguage);
    });
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kLocaleLanguageKey, locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InSeason',
      theme: ThemeData(
        primaryColor: const Color(0xFFF04800),
        scaffoldBackgroundColor: const Color(0xFFD6FFEE),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF240041)),
        ),
        colorScheme: const ColorScheme(
          primary: Color(0xFF240041),
          secondary: Color(0xFF74ce9e),
          surface: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 12.0,
          shadowColor: Colors.black.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: Colors.grey.withValues(alpha: 0.7), width: 2),
          ),
          color: Colors.white,
          margin: const EdgeInsets.all(16.0),
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('sv'), // Swedish
      ],
      locale: _locale,
      home: ProduceListPage(onLocaleChange: setLocale),
    );
  }
}
