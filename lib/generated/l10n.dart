// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `IN SEASON`
  String get appTitle {
    return Intl.message('IN SEASON', name: 'appTitle', desc: '', args: []);
  }

  /// `SETTINGS`
  String get settings {
    return Intl.message('SETTINGS', name: 'settings', desc: '', args: []);
  }

  /// `LANGUAGE`
  String get language {
    return Intl.message('LANGUAGE', name: 'language', desc: '', args: []);
  }

  /// `LOCATION`
  String get location {
    return Intl.message('LOCATION', name: 'location', desc: '', args: []);
  }

  /// `Sweden`
  String get sweden {
    return Intl.message('Sweden', name: 'sweden', desc: '', args: []);
  }

  /// `Andalucia`
  String get andalucia {
    return Intl.message('Andalucia', name: 'andalucia', desc: '', args: []);
  }

  /// `Swedish`
  String get swedish {
    return Intl.message('Swedish', name: 'swedish', desc: '', args: []);
  }

  /// `Spanish`
  String get spanish {
    return Intl.message('Spanish', name: 'spanish', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Apples`
  String get apples {
    return Intl.message('Apples', name: 'apples', desc: '', args: []);
  }

  /// `Strawberries`
  String get strawberries {
    return Intl.message(
      'Strawberries',
      name: 'strawberries',
      desc: '',
      args: [],
    );
  }

  /// `Blueberries`
  String get blueberries {
    return Intl.message('Blueberries', name: 'blueberries', desc: '', args: []);
  }

  /// `Raspberries`
  String get raspberries {
    return Intl.message('Raspberries', name: 'raspberries', desc: '', args: []);
  }

  /// `Mushrooms`
  String get mushrooms {
    return Intl.message('Mushrooms', name: 'mushrooms', desc: '', args: []);
  }

  /// `Grapes`
  String get grapes {
    return Intl.message('Grapes', name: 'grapes', desc: '', args: []);
  }

  /// `Pears`
  String get pears {
    return Intl.message('Pears', name: 'pears', desc: '', args: []);
  }

  /// `Plums`
  String get plums {
    return Intl.message('Plums', name: 'plums', desc: '', args: []);
  }

  /// `Cherries`
  String get cherries {
    return Intl.message('Cherries', name: 'cherries', desc: '', args: []);
  }

  /// `Beets`
  String get beets {
    return Intl.message('Beets', name: 'beets', desc: '', args: []);
  }

  /// `Potatoes`
  String get potatoes {
    return Intl.message('Potatoes', name: 'potatoes', desc: '', args: []);
  }

  /// `Carrots`
  String get carrots {
    return Intl.message('Carrots', name: 'carrots', desc: '', args: []);
  }

  /// `Broccoli`
  String get broccoli {
    return Intl.message('Broccoli', name: 'broccoli', desc: '', args: []);
  }

  /// `Cauliflower`
  String get cauliflower {
    return Intl.message('Cauliflower', name: 'cauliflower', desc: '', args: []);
  }

  /// `Peas`
  String get peas {
    return Intl.message('Peas', name: 'peas', desc: '', args: []);
  }

  /// `Cabbage`
  String get cabbage {
    return Intl.message('Cabbage', name: 'cabbage', desc: '', args: []);
  }

  /// `Kale`
  String get kale {
    return Intl.message('Kale', name: 'kale', desc: '', args: []);
  }

  /// `Brussels Sprouts`
  String get brusselsSprouts {
    return Intl.message(
      'Brussels Sprouts',
      name: 'brusselsSprouts',
      desc: '',
      args: [],
    );
  }

  /// `Papaya`
  String get papaya {
    return Intl.message('Papaya', name: 'papaya', desc: '', args: []);
  }

  /// `Pineapple`
  String get pineapple {
    return Intl.message('Pineapple', name: 'pineapple', desc: '', args: []);
  }

  /// `Mango`
  String get mango {
    return Intl.message('Mango', name: 'mango', desc: '', args: []);
  }

  /// `Passionfruit`
  String get passionfruit {
    return Intl.message(
      'Passionfruit',
      name: 'passionfruit',
      desc: '',
      args: [],
    );
  }

  /// `Kiwi`
  String get kiwi {
    return Intl.message('Kiwi', name: 'kiwi', desc: '', args: []);
  }

  /// `Lychee`
  String get lychee {
    return Intl.message('Lychee', name: 'lychee', desc: '', args: []);
  }

  /// `Pomegranate`
  String get pomegranate {
    return Intl.message('Pomegranate', name: 'pomegranate', desc: '', args: []);
  }

  /// `Coconut`
  String get coconut {
    return Intl.message('Coconut', name: 'coconut', desc: '', args: []);
  }

  /// `Avocado`
  String get avocado {
    return Intl.message('Avocado', name: 'avocado', desc: '', args: []);
  }

  /// `Oranges`
  String get oranges {
    return Intl.message('Oranges', name: 'oranges', desc: '', args: []);
  }

  /// `Lemons`
  String get lemons {
    return Intl.message('Lemons', name: 'lemons', desc: '', args: []);
  }

  /// `Olives`
  String get olives {
    return Intl.message('Olives', name: 'olives', desc: '', args: []);
  }

  /// `Almonds`
  String get almonds {
    return Intl.message('Almonds', name: 'almonds', desc: '', args: []);
  }

  /// `Figs`
  String get figs {
    return Intl.message('Figs', name: 'figs', desc: '', args: []);
  }

  /// `Lingonberries`
  String get lingonberries {
    return Intl.message(
      'Lingonberries',
      name: 'lingonberries',
      desc: '',
      args: [],
    );
  }

  /// `Cloudberries`
  String get cloudberries {
    return Intl.message(
      'Cloudberries',
      name: 'cloudberries',
      desc: '',
      args: [],
    );
  }

  /// `Rhubarb`
  String get rhubarb {
    return Intl.message('Rhubarb', name: 'rhubarb', desc: '', args: []);
  }

  /// `Cranberries`
  String get cranberries {
    return Intl.message('Cranberries', name: 'cranberries', desc: '', args: []);
  }

  /// `Blackcurrants`
  String get blackcurrants {
    return Intl.message(
      'Blackcurrants',
      name: 'blackcurrants',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'sv'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
