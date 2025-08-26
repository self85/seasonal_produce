import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:seasonal_produce/models/produce_item.dart';
import 'package:seasonal_produce/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';

const String kSelectedLocationKey = 'selected_location';
const String kSelectedLanguageKey = 'selected_language';
const String kFavoritesKey = 'favorites';

enum ViewType {
  list,
  icon,
  card,
}

enum SortType {
  none,
  alphabetical,
  seasonal,
  favorite,
}

class ProduceListPage extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const ProduceListPage({super.key, required this.onLocaleChange});

  @override
  ProduceListPageState createState() => ProduceListPageState();
}

class ProduceListPageState extends State<ProduceListPage> with TickerProviderStateMixin {
  String? _selectedLocation = "sweden";
  String? _selectedLanguage = "english";
  late List<ProduceItem> items;
  bool _isExpanded = false;
  bool _isSortMenuExpanded = false;
  bool _isViewMenuExpanded = false;
  bool _isLanguageMenuExpanded = false;
  SortType _currentSort = SortType.none;
  Set<String> _favorites = {};
  AnimationController? _animationController;
  final Map<String, AnimationController> _flipControllers = {};
  final Map<String, bool> _showDetailedNutrition = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLocation = prefs.getString(kSelectedLocationKey) ?? "sweden";
      _selectedLanguage = prefs.getString(kSelectedLanguageKey) ?? "english";
      _favorites = prefs.getStringList(kFavoritesKey)?.toSet() ?? {};
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kSelectedLocationKey, _selectedLocation ?? "sweden");
    await prefs.setString(kSelectedLanguageKey, _selectedLanguage ?? "english");
    await prefs.setStringList(kFavoritesKey, _favorites.toList());
  }

  @override
  void dispose() {
    _animationController?.dispose();
    for (var controller in _flipControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = [
      ProduceItem(AppLocalizations.of(context)!.apples, 'assets/produce/apple.jpeg', {
      'sweden': [1, 2, 3, 8, 9, 10, 11, 12],
      'andalucia': [9, 10, 11, 12]
    }, NutritionInfo(
        carbs: 10.6, 
        fats: 0.0, 
        proteins: 0.0, 
        fiber: 2.3,
        calories: 48,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 9.9,
          starch: 0.0,
          water: 86.9,
          betaCarotene: 22.0,
          vitaminA: 22.0,
          vitaminC: 4.8,
          vitaminK: 0.0,
          vitaminE: 0.3,
          thiamin: 0.02,
          riboflavin: 0.03,
          niacin: 0.1,
          vitaminB6: 0.04,
          folate: 2.9,
          potassium: 62.0,
          calcium: 3.0,
          magnesium: 4.0,
          phosphorus: 7.0,
          iron: 0.1,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.strawberries, 'assets/produce/strawberry.jpeg', {
      'sweden': [6, 7, 8],
      'andalucia': [3, 4, 5, 6]
    }, NutritionInfo(
        carbs: 8.3, 
        fats: 0.2, 
        proteins: 0.5, 
        fiber: 1.9,
        calories: 41,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 7.9,
          starch: 0.0,
          vitaminA: 0.8,
          vitaminC: 60.8,
          vitaminK: 0.0,
          vitaminE: 0.6,
          thiamin: 0.02,
          riboflavin: 0.02,
          niacin: 0.4,
          vitaminB6: 0.05,
          folate: 85.7,
          potassium: 130.0,
          calcium: 18.0,
          magnesium: 11.0,
          phosphorus: 20.0,
          iron: 0.34,
          water: 91.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.blueberries, 'assets/produce/blueberry.jpeg', {
      'sweden': [7, 8],
      'andalucia': [5, 6, 7]
    }, NutritionInfo(
        carbs: 9.1, 
        fats: 0.8, 
        proteins: 0.7, 
        fiber: 3.1,
        calories: 53,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 6.4,
          starch: 0.0,
          water: 84.2,
          betaCarotene: 40.0,
          vitaminA: 8.5,
          vitaminC: 8.1,
          vitaminK: 0.0,
          vitaminE: 0.1,
          thiamin: 0.04,
          riboflavin: 0.04,
          niacin: 0.4,
          vitaminB6: 0.05,
          folate: 10.2,
          potassium: 86.0,
          calcium: 23.0,
          magnesium: 9.0,
          phosphorus: 20.0,
          iron: 0.6,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.raspberries, 'assets/produce/raspberry.jpeg', {
      'sweden': [7, 8],
      'andalucia': [5, 6, 7, 8]
    }, NutritionInfo(
        carbs: 4.1, 
        fats: 0.6, 
        proteins: 1.2, 
        fiber: 3.7,
        calories: 34,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.1,
          polyunsaturatedFat: 0.4,
          sugar: 4.1,
          starch: 0.0,
          vitaminA: 1.0,
          vitaminC: 27.0,
          vitaminK: 11.0,
          vitaminE: 1.4,
          thiamin: 0.03,
          riboflavin: 0.04,
          niacin: 0.6,
          vitaminB6: 0.06,
          folate: 46.0,
          potassium: 150.0,
          calcium: 27.0,
          magnesium: 25.0,
          phosphorus: 28.0,
          iron: 1.1, 
          water: 1.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.mushrooms, 'assets/produce/mushroom.jpeg', {
      'sweden': [7, 8, 9, 10],
      'andalucia': [1, 2, 3, 10, 11, 12]
    }, NutritionInfo(
        carbs: 2.9, 
        fats: 0.2, 
        proteins: 2.5, 
        fiber: 1.3,
        calories: 26,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          sugar: 1.5,
          starch: 0.0,
          vitaminA: 0.0,
          vitaminC: 5.0,
          vitaminK: 1.0,
          vitaminE: 0.0,
          thiamin: 0.08,
          riboflavin: 0.4,
          niacin: 3.6,
          vitaminB6: 0.1,
          folate: 31.0,
          potassium: 389.0,
          calcium: 6.0,
          magnesium: 12.0,
          phosphorus: 112.0,
          iron: 0.33,
          water: 92.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.grapes, 'assets/produce/grape.jpeg', {
      'sweden': [7, 8, 9, 10, 11, 12],
      'andalucia': [8, 9, 10]
    }, NutritionInfo(
        carbs: 15.6, 
        fats: 0.2, 
        proteins: 0.6, 
        fiber: 1.2,
        calories: 70,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 16.1,
          starch: 0.0,
          vitaminA: 7.0,
          vitaminC: 2.5,
          vitaminK: 0.0,
          vitaminE: 0.2,
          folate: 6.0,
          potassium: 215.0,
          calcium: 10.0,
          magnesium: 7.0,
          phosphorus: 13.0,
          iron: 0.3,
          water: 81.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.pears, 'assets/produce/pear.jpeg', {
      'sweden': [8, 9, 10, 11],
      'andalucia': [8, 9, 10, 11]
    }, NutritionInfo(
        carbs: 11.5, 
        fats: 0.1, 
        proteins: 0.3, 
        fiber: 2.7,
        calories: 54,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 11.3,
          starch: 0.0,
          vitaminA: 14.0,
          vitaminC: 5.0,
          vitaminK: 5.0,
          vitaminE: 0.5,
          folate: 6.0,
          potassium: 106.0,
          calcium: 11.0,
          magnesium: 7.0,
          phosphorus: 11.0,
          iron: 0.18,
          water: 84.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.plums, 'assets/produce/plum.jpeg', {
      'sweden': [8, 9, 10],
      'andalucia': [6, 7, 8]
    }, NutritionInfo(
        carbs: 10.2, 
        fats: 0.1, 
        proteins: 0.5, 
        fiber: 1.8,
        calories: 47,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 7.2,
          starch: 0.0,
          vitaminA: 36.0,
          vitaminC: 10.0,
          vitaminK: 7.0,
          vitaminE: 0.3,
          folate: 1.0,
          potassium: 154.0,
          calcium: 8.0,
          magnesium: 10.0,
          phosphorus: 14.0,
          iron: 0.15,
          water: 87.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.cherries, 'assets/produce/cherry.jpeg', {
      'sweden': [7, 8, 9],
      'andalucia': [5, 6, 7]
    }, NutritionInfo(
        carbs: 14.7, 
        fats: 0.1, 
        proteins: 1.1, 
        fiber: 1.9,
        calories: 69,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 12.8,
          starch: 0.0,
          vitaminA: 6.0,
          vitaminC: 12.0,
          vitaminK: 3.0,
          vitaminE: 0.6,
          folate: 25.0,
          potassium: 286.0,
          calcium: 17.0,
          magnesium: 8.0,
          phosphorus: 22.0,
          iron: 0.3,
          water: 82.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.beets, 'assets/produce/beet.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 9, 10, 11, 12]
    }, NutritionInfo(
        carbs: 9.8, 
        fats: 0.1, 
        proteins: 1.2, 
        fiber: 2.6,
        calories: 51,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 6.8,
          starch: 0.3,
          vitaminA: 2.0,
          vitaminC: 3.0,
          vitaminK: 0.0,
          vitaminE: 0.0,
          folate: 69.0,
          potassium: 280.0,
          calcium: 22.0,
          magnesium: 14.0,
          phosphorus: 28.0,
          iron: 0.31,
          water: 88.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.potatoes, 'assets/produce/potato.jpeg', {
      'sweden': [5, 6, 7, 8, 9],
      'andalucia': [3, 4, 5, 6, 7]
    }, NutritionInfo(
        carbs: 16.1, 
        fats: 0.1, 
        proteins: 1.8, 
        fiber: 1.4,
        calories: 76,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          sugar: 0.8,
          starch: 15.3,
          vitaminA: 0.0,
          vitaminC: 11.0,
          vitaminK: 2.0,
          vitaminE: 0.0,
          thiamin: 0.08,
          riboflavin: 0.03,
          niacin: 1.1,
          vitaminB6: 0.3,
          folate: 19.0,
          potassium: 468.0,
          calcium: 9.0,
          magnesium: 24.0,
          phosphorus: 31.0,
          iron: 0.48,
          water: 79.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.carrots, 'assets/produce/carrot.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 9, 10, 11, 12]
    }, NutritionInfo(
        carbs: 6.6, 
        fats: 0.2, 
        proteins: 0.7, 
        fiber: 2.4,
        calories: 36,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          sugar: 4.7,
          starch: 1.4,
          vitaminA: 862.0,
          vitaminC: 5.0,
          vitaminK: 8.0,
          vitaminE: 1.0,
          thiamin: 0.07,
          riboflavin: 0.06,
          niacin: 1.0,
          vitaminB6: 0.1,
          folate: 22.0,
          potassium: 210.0,
          calcium: 26.0,
          magnesium: 8.0,
          phosphorus: 23.0,
          iron: 0.19,
          water: 88.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.broccoli, 'assets/produce/broccoli.jpeg', {
      'sweden': [6, 7, 8, 9, 10, 11],
      'andalucia': [11, 12, 1, 2, 3, 4]
    }, NutritionInfo(
        carbs: 3.1, 
        fats: 0.3, 
        proteins: 3.5, 
        fiber: 3.1,
        calories: 35,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          sugar: 1.4,
          starch: 0.0,
          vitaminA: 39.0,
          vitaminC: 83.0,
          vitaminK: 140.0,
          vitaminE: 0.4,
          thiamin: 0.1,
          riboflavin: 0.1,
          niacin: 0.6,
          vitaminB6: 0.2,
          folate: 175.0,
          potassium: 332.0,
          calcium: 62.0,
          magnesium: 23.0,
          phosphorus: 81.0,
          iron: 0.66,
          water: 89.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.cauliflower, 'assets/produce/cauliflower.jpeg', {
      'sweden': [5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [10, 11, 12, 1, 2, 3]
    }, NutritionInfo(
        carbs: 2.6, 
        fats: 0.2, 
        proteins: 1.9, 
        fiber: 2.3,
        calories: 24,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          sugar: 2.0,
          starch: 0.0,
          vitaminA: 0.0,
          vitaminC: 79.0,
          vitaminK: 27.0,
          vitaminE: 0.0,
          folate: 88.0,
          potassium: 340.0,
          calcium: 23.0,
          magnesium: 11.0,
          phosphorus: 43.0,
          iron: 0.34,
          water: 92.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.peas, 'assets/produce/pea.jpeg', {
      'sweden': [6, 7, 8, 9, 10],
      'andalucia': [4, 5, 6]
    }, NutritionInfo(
        carbs: 8.8, 
        fats: 0.4, 
        proteins: 5.4, 
        fiber: 5.5,
        calories: 72,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.2,
          sugar: 4.5,
          starch: 4.0,
          vitaminA: 46.0,
          vitaminC: 40.0,
          vitaminK: 25.0,
          vitaminE: 0.0,
          thiamin: 0.3,
          riboflavin: 0.1,
          niacin: 2.1,
          vitaminB6: 0.2,
          folate: 65.0,
          potassium: 370.0,
          calcium: 25.0,
          magnesium: 40.0,
          phosphorus: 130.0,
          iron: 2.0,
          water: 79.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.cabbage, 'assets/produce/cabbage.jpeg', {
      'sweden': [1, 2, 3, 4, 7, 8, 9, 10, 11, 12],
      'andalucia': [10, 11, 12, 1, 2, 3, 4]
    }, NutritionInfo(
        carbs: 4.7, 
        fats: 0.1, 
        proteins: 1.1, 
        fiber: 2.6,
        calories: 30,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          sugar: 3.2,
          starch: 0.0,
          vitaminA: 1.0,
          vitaminC: 46.0,
          vitaminK: 44.0,
          vitaminE: 0.0,
          folate: 19.0,
          potassium: 240.0,
          calcium: 41.0,
          magnesium: 11.0,
          phosphorus: 24.0,
          iron: 0.21,
          water: 92.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.kale, 'assets/produce/kale.jpeg', {
      'sweden': [1, 2, 10, 11, 12],
      'andalucia': [11, 12, 1, 2]
    }, NutritionInfo(
        carbs: 5.7, 
        fats: 0.7, 
        proteins: 3.3, 
        fiber: 3.8,
        calories: 50,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.5,
          sugar: 2.3,
          starch: 0.0,
          vitaminA: 446.0,
          vitaminC: 120.0,
          vitaminK: 400.0,
          vitaminE: 5.4,
          thiamin: 0.1,
          riboflavin: 0.1,
          niacin: 1.0,
          vitaminB6: 0.3,
          folate: 30.0,
          potassium: 530.0,
          calcium: 157.0,
          magnesium: 35.0,
          phosphorus: 56.0,
          iron: 1.7,
          water: 84.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.brusselsSprouts, 'assets/produce/brusselsprout.jpeg', {
      'sweden': [1, 2, 3, 9, 10, 11, 12],
      'andalucia': [11, 12, 1, 2]
    }, NutritionInfo(
        carbs: 4.7, 
        fats: 0.3, 
        proteins: 3.4, 
        fiber: 4.2,
        calories: 44,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.2,
          sugar: 2.2,
          starch: 0.0,
          vitaminA: 36.0,
          vitaminC: 85.0,
          vitaminK: 140.0,
          vitaminE: 0.0,
          thiamin: 0.1,
          riboflavin: 0.1,
          niacin: 0.7,
          vitaminB6: 0.2,
          folate: 159.0,
          potassium: 390.0,
          calcium: 42.0,
          magnesium: 23.0,
          phosphorus: 69.0,
          iron: 1.4,
          water: 86.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.papaya, 'assets/produce/papaya.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }, NutritionInfo(
        carbs: 7.2, 
        fats: 0.1, 
        proteins: 0.6, 
        fiber: 2.6,
        calories: 43,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 7.2,
          starch: 0.0,
          water: 89.0,
          vitaminA: 950.0,
          vitaminC: 61.0,
          vitaminK: 2.0,
          vitaminE: 0.3,
          folate: 37.0,
          potassium: 182.0,
          calcium: 20.0,
          magnesium: 21.0,
          phosphorus: 10.0,
          iron: 0.25,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.pineapple, 'assets/produce/pineapple.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }, NutritionInfo(
        carbs: 13.1, 
        fats: 0.1, 
        proteins: 0.5, 
        fiber: 1.4,
        calories: 50,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 13.1,
          starch: 0.0,
          water: 86.0,
          vitaminA: 58.0,
          vitaminC: 47.8,
          vitaminK: 0.7,
          vitaminE: 0.02,
          folate: 18.0,
          potassium: 109.0,
          calcium: 13.0,
          magnesium: 12.0,
          phosphorus: 8.0,
          iron: 0.29,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.mango, 'assets/produce/mango.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [8, 9, 10]
    }, NutritionInfo(
        carbs: 15.0, 
        fats: 0.4, 
        proteins: 0.8, 
        fiber: 1.6,
        calories: 60,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.1,
          polyunsaturatedFat: 0.1,
          sugar: 13.7,
          starch: 0.0,
          water: 83.5,
          vitaminA: 1082.0,
          vitaminC: 36.4,
          vitaminK: 4.2,
          vitaminE: 0.9,
          folate: 43.0,
          potassium: 168.0,
          calcium: 11.0,
          magnesium: 10.0,
          phosphorus: 14.0,
          iron: 0.16,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.passionfruit, 'assets/produce/passionfruit.jpeg', {
      'sweden': [1, 2, 3, 4, 7, 8, 9, 10, 12],
      'andalucia': [8, 9, 10]
    }, NutritionInfo(
        carbs: 23.4, 
        fats: 0.7, 
        proteins: 2.2, 
        fiber: 10.4,
        calories: 97,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.1,
          polyunsaturatedFat: 0.4,
          sugar: 11.2,
          starch: 0.0,
          water: 72.9,
          vitaminA: 1274.0,
          vitaminC: 30.0,
          vitaminK: 0.7,
          vitaminE: 0.02,
          folate: 14.0,
          potassium: 348.0,
          calcium: 12.0,
          magnesium: 29.0,
          phosphorus: 68.0,
          iron: 1.6,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.kiwi, 'assets/produce/kiwi.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [11, 12, 1, 2, 3, 4]
    }, NutritionInfo(
        carbs: 14.7, 
        fats: 0.5, 
        proteins: 1.1, 
        fiber: 3.0,
        calories: 61,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.3,
          sugar: 9.0,
          starch: 0.0,
          water: 83.1,
          vitaminA: 87.0,
          vitaminC: 92.7,
          vitaminK: 40.3,
          vitaminE: 1.5,
          folate: 25.0,
          potassium: 312.0,
          calcium: 34.0,
          magnesium: 17.0,
          phosphorus: 34.0,
          iron: 0.31,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.lychee, 'assets/produce/lychee.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [7, 8]
    }, NutritionInfo(
        carbs: 16.5, 
        fats: 0.4, 
        proteins: 0.8, 
        fiber: 1.3,
        calories: 66,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.1,
          polyunsaturatedFat: 0.1,
          sugar: 15.2,
          starch: 0.0,
          water: 81.8,
          vitaminA: 0.0,
          vitaminC: 71.5,
          vitaminK: 0.4,
          vitaminE: 0.07,
          folate: 14.0,
          potassium: 171.0,
          calcium: 5.0,
          magnesium: 10.0,
          phosphorus: 31.0,
          iron: 0.31,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.pomegranate, 'assets/produce/pomegranate.jpeg', {
      'sweden': [1, 2, 3, 9, 10, 11, 12],
      'andalucia': [9, 10, 11, 12]
    }, NutritionInfo(
        carbs: 18.7, 
        fats: 1.2, 
        proteins: 1.7, 
        fiber: 4.0,
        calories: 83,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.1,
          polyunsaturatedFat: 0.1,
          sugar: 13.7,
          starch: 0.0,
          water: 77.9,
          vitaminA: 0.0,
          vitaminC: 10.2,
          vitaminK: 16.4,
          vitaminE: 0.6,
          folate: 38.0,
          potassium: 236.0,
          calcium: 10.0,
          magnesium: 12.0,
          phosphorus: 36.0,
          iron: 0.3,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.coconut, 'assets/produce/coconut.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }, NutritionInfo(
        carbs: 15.2, 
        fats: 33.5, 
        proteins: 3.3, 
        fiber: 9.0,
        calories: 354,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 29.7,
          monounsaturatedFat: 1.4,
          polyunsaturatedFat: 0.4,
          sugar: 6.2,
          starch: 0.0,
          water: 47.0,
          vitaminA: 0.0,
          vitaminC: 3.3,
          vitaminK: 0.2,
          vitaminE: 0.24,
          folate: 26.0,
          potassium: 356.0,
          calcium: 14.0,
          magnesium: 32.0,
          phosphorus: 113.0,
          iron: 2.43,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.avocado, 'assets/produce/avocado.jpeg', {
      'sweden': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
      'andalucia': [10, 11, 12, 1, 2, 3, 4, 5]
    }, NutritionInfo(
        carbs: 6.5, 
        fats: 19.6, 
        proteins: 1.9, 
        fiber: 4.8,
        calories: 197,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 3.4,
          monounsaturatedFat: 12.7,
          polyunsaturatedFat: 2.6,
          sugar: 0.0,
          starch: 1.7,
          vitaminA: 0.0,
          vitaminC: 3.3,
          vitaminK: 0.0,
          vitaminE: 3.4,
          thiamin: 0.1,
          riboflavin: 0.2,
          niacin: 1.7,
          vitaminB6: 0.3,
          folate: 116.0,
          potassium: 600.0,
          calcium: 14.0,
          magnesium: 32.0,
          phosphorus: 67.0,
          iron: 0.3,
          water: 73.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.oranges, 'assets/produce/orange.jpeg', {
      'sweden': [], 
      'andalucia': [1, 2, 3, 10, 11, 12]
    }, NutritionInfo(
        carbs: 10.4, 
        fats: 0.2, 
        proteins: 0.8, 
        fiber: 1.2,
        calories: 50,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 8.2,
          starch: 0.0,
          vitaminA: 4.6,
          vitaminC: 52.0,
          vitaminK: 0.0,
          vitaminE: 0.4,
          folate: 33.0,
          potassium: 122.0,
          calcium: 24.0,
          magnesium: 8.0,
          phosphorus: 16.0,
          iron: 0.1,
          water: 87.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.lemons, 'assets/produce/lemon.jpeg', {
      'sweden': [], 
      'andalucia': [1, 2, 3, 10, 11, 12]
    }, NutritionInfo(
        carbs: 7.6, 
        fats: 0.7, 
        proteins: 0.9, 
        fiber: 4.9,
        calories: 50,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 2.6,
          starch: 0.0,
          vitaminA: 0.0,
          vitaminC: 100.0,
          vitaminK: 0.0,
          vitaminE: 1.6,
          folate: 31.0,
          potassium: 130.0,
          calcium: 67.0,
          magnesium: 11.0,
          phosphorus: 15.0,
          iron: 0.2,
          water: 89.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.olives, 'assets/produce/olive.jpeg', {
      'sweden': [], 
      'andalucia': [10, 11, 12, 1, 2, 3]
    }, NutritionInfo(
        carbs: 3.8, 
        fats: 15.3, 
        proteins: 1.0, 
        fiber: 3.3,
        calories: 145,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 2.0,
          monounsaturatedFat: 11.3,
          polyunsaturatedFat: 1.3,
          sugar: 0.5,
          starch: 0.0,
          water: 75.3,
          vitaminA: 20.0,
          vitaminC: 0.9,
          vitaminK: 1.4,
          vitaminE: 3.8,
          folate: 3.0,
          potassium: 42.0,
          calcium: 52.0,
          magnesium: 11.0,
          phosphorus: 4.0,
          iron: 0.49,
          sodium: 1556.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.almonds, 'assets/produce/almond.jpeg', {
      'sweden': [], 
      'andalucia': [8, 9, 10]
    }, NutritionInfo(
        carbs: 21.6, 
        fats: 49.9, 
        proteins: 21.2, 
        fiber: 12.5,
        calories: 579,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 3.8,
          monounsaturatedFat: 31.6,
          polyunsaturatedFat: 12.3,
          sugar: 4.4,
          starch: 0.7,
          water: 4.4,
          vitaminA: 0.0,
          vitaminC: 0.0,
          vitaminK: 0.0,
          vitaminE: 25.6,
          thiamin: 0.2,
          riboflavin: 1.1,
          niacin: 3.6,
          vitaminB6: 0.1,
          folate: 44.0,
          potassium: 733.0,
          calcium: 269.0,
          magnesium: 270.0,
          phosphorus: 481.0,
          iron: 3.7,
          zinc: 3.1,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.figs, 'assets/produce/fig.jpeg', {
      'sweden': [], 
      'andalucia': [7, 8, 9]
    }, NutritionInfo(
        carbs: 19.2, 
        fats: 0.3, 
        proteins: 0.8, 
        fiber: 2.9,
        calories: 74,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.1,
          polyunsaturatedFat: 0.1,
          sugar: 16.3,
          starch: 0.0,
          water: 79.1,
          vitaminA: 7.0,
          vitaminC: 2.0,
          vitaminK: 4.7,
          vitaminE: 0.11,
          folate: 6.0,
          potassium: 232.0,
          calcium: 35.0,
          magnesium: 17.0,
          phosphorus: 14.0,
          iron: 0.37,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.lingonberries, 'assets/produce/lingonberry.jpeg', {
      'sweden': [8, 9, 10],
      'andalucia': [] 
    }, NutritionInfo(
        carbs: 10.7, 
        fats: 0.7, 
        proteins: 0.5, 
        fiber: 2.6,
        calories: 56,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 8.1,
          starch: 0.0,
          vitaminA: 8.0,
          vitaminC: 10.7,
          vitaminK: 0.0,
          vitaminE: 1.5,
          folate: 19.6,
          potassium: 80.0,
          calcium: 22.0,
          magnesium: 9.0,
          phosphorus: 17.0,
          iron: 0.4,
          water: 86.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.cloudberries, 'assets/produce/cloudberry.jpeg', {
      'sweden': [7, 8],
      'andalucia': [] 
    }, NutritionInfo(
        carbs: 11.4, 
        fats: 1.1, 
        proteins: 1.5, 
        fiber: 6.3,
        calories: 48,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 5.7,
          starch: 0.0,
          vitaminA: 140.0,
          vitaminC: 61.6,
          vitaminK: 0.0,
          vitaminE: 3.0,
          folate: 37.9,
          potassium: 170.0,
          calcium: 16.0,
          magnesium: 29.0,
          phosphorus: 36.0,
          iron: 0.7,
          water: 84.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.rhubarb, 'assets/produce/rhubarb.jpeg', {
      'sweden': [5, 6, 7],
      'andalucia': []
    }, NutritionInfo(
        carbs: 2.7, 
        fats: 0.2, 
        proteins: 0.9, 
        fiber: 1.4,
        calories: 19,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.1,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.1,
          vitaminA: 5.0,
          vitaminC: 13.0,
          vitaminK: 0.0,
          vitaminE: 0.0,
          folate: 7.0,
          potassium: 280.0,
          calcium: 140.0,
          magnesium: 12.0,
          phosphorus: 17.0,
          iron: 0.3,
          water: 1.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.cranberries, 'assets/produce/cranberry.jpeg', {
      'sweden': [9, 10],
      'andalucia': [] 
    }, NutritionInfo(
        carbs: 8.9, 
        fats: 0.2, 
        proteins: 0.4, 
        fiber: 3.3,
        calories: 46,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 3.4,
          starch: 0.0,
          vitaminA: 22.0,
          vitaminC: 10.0,
          vitaminK: 0.0,
          vitaminE: 1.6,
          folate: 2.0,
          potassium: 80.0,
          calcium: 15.0,
          magnesium: 8.0,
          phosphorus: 15.0,
          iron: 0.7,
          water: 87.0,
        )
      )),
    ProduceItem(AppLocalizations.of(context)!.blackcurrants, 'assets/produce/blackcurrant.jpeg', {
      'sweden': [7, 8],
      'andalucia': [] 
    }, NutritionInfo(
        carbs: 10.2, 
        fats: 1.1, 
        proteins: 1.4, 
        fiber: 5.8,
        calories: 68,
        detailedInfo: DetailedNutritionInfo(
          saturatedFat: 0.0,
          monounsaturatedFat: 0.0,
          polyunsaturatedFat: 0.0,
          sugar: 8.5,
          starch: 0.0,
          vitaminA: 103.0,
          vitaminC: 128.0,
          vitaminK: 0.0,
          vitaminE: 2.2,
          folate: 14.2,
          potassium: 340.0,
          calcium: 72.0,
          magnesium: 24.0,
          phosphorus: 58.0,
          iron: 1.2,
          water: 82.0,
        )
      ))
    ];
  }

  ViewType _viewType = ViewType.card;

  @override
  Widget build(BuildContext context) {
    final String appTitle = AppLocalizations.of(context)!.appTitle;
    int currentMonth = DateTime.now().month;
    var itemsInSeason = _selectedLocation != null
        ? items.where((item) => item.isInSeason(_selectedLocation!, currentMonth)).toList()
        : items;
    
    itemsInSeason = _sortItems(itemsInSeason);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3B0D3A),
        title: Text(appTitle),
        titleTextStyle: const TextStyle(
          fontFamily: 'BebasNeue',
          fontSize: 40,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_pin, color: Colors.white),
            onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      selectedLocation: _selectedLocation,
                      selectedLanguage: _selectedLanguage,
                      onLocaleChange: widget.onLocaleChange,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    _selectedLocation = result['selectedLocation'];
                    _selectedLanguage = result['selectedLanguage'];
                    _savePreferences();
                  });
                }
              },
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildView(itemsInSeason),
          if (_isExpanded) _buildExpandedMenu(),
          if (_isSortMenuExpanded) _buildSortingMenu(),
          if (_isViewMenuExpanded) _buildViewMenu(),
          if (_isLanguageMenuExpanded) _buildLanguageMenu(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
            if (_isExpanded) {
              _animationController?.forward();
            } else {
              _animationController?.reverse();
              _isSortMenuExpanded = false;
              _isViewMenuExpanded = false;
              _isLanguageMenuExpanded = false;
            }
          });
        },
        backgroundColor: const Color(0xFF3B0D3A),
        child: _animationController != null 
            ? AnimatedBuilder(
                animation: _animationController!,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animationController!.value * (math.pi / 2), // 45 degrees in radians
                    child: Icon(
                      _isExpanded ? Icons.close : Icons.add,
                      color: Colors.white,
                      size: _isExpanded ? 34.0 : 38.0,
                    ),
                  );
                },
              )
            : Icon(
                _isExpanded ? Icons.close : Icons.add,
                color: Colors.white,
                size: _isExpanded ? 34.0 : 38.0,
              ),
      ),
    );
  }

  Widget _buildView(List<ProduceItem> items) {
    switch (_viewType) {
      case ViewType.list:
        return _buildListView(items);
      case ViewType.icon:
        return _buildGridView(items);
      case ViewType.card:
      return _buildCardView(items);
    }
  }

  Widget _buildListView(List<ProduceItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: IconButton(
            icon: Icon(
              isFavorite(items[index].name) ? Icons.favorite : Icons.favorite_border,
              color: isFavorite(items[index].name) ? Colors.red : Colors.grey,
            ),
            onPressed: () => toggleFavorite(items[index].name),
          ),
          title: Text(
            items[index].name,
            style: const TextStyle(
              fontSize: 20.0,
              color: Color(0xFF240041),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<ProduceItem> items) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 3 : // Phone
                        screenWidth < 900 ? 4 : // Small tablet
                        screenWidth < 1200 ? 5 : // Large tablet
                        6; // Extra large tablet

    double padding = screenWidth > 600 ? 16.0 : 10.0;
    double imageSize = screenWidth > 600 ? 180.0 : 100.0;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: padding,
          crossAxisSpacing: padding,
          childAspectRatio: 0.7, // Made taller to accommodate longer text
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        items[index].imagePath,
                        fit: BoxFit.cover,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 3,
                      child: GestureDetector(
                        onTap: () => toggleFavorite(items[index].name),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isFavorite(items[index].name) ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite(items[index].name) ? Colors.red : Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2, // Increased flex for text container
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      items[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth > 600 ? 18.0 : 14.0,
                        fontFamily: 'BebasNeue',
                        color: const Color(0xFF240041),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCardView(List<ProduceItem> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final itemKey = '${item.name}_$index';
        
        // Create animation controller for this card if not exists
        if (!_flipControllers.containsKey(itemKey)) {
          _flipControllers[itemKey] = AnimationController(
            duration: const Duration(milliseconds: 600),
            vsync: this,
          );
        }
        
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () => _flipCard(itemKey),
            child: AnimatedBuilder(
              animation: _flipControllers[itemKey]!,
              builder: (context, child) {
                final isShowingBack = _flipControllers[itemKey]!.value > 0.5;
                final isDetailedView = _showDetailedNutrition[item.name] ?? false;
                
                // If showing detailed nutrition, return fullscreen without transform
                if (isShowingBack && isDetailedView) {
                  return _buildNutritionCard(item);
                }
                
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_flipControllers[itemKey]!.value * math.pi),
                  child: isShowingBack 
                    ? _buildNutritionCard(item)
                    : _buildFrontCard(item),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpandedMenu() {
    return Positioned(
      bottom: 90,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // View options button
          FloatingActionButton(
            mini: true,
            heroTag: "view",
            onPressed: () {
              setState(() {
                _isViewMenuExpanded = !_isViewMenuExpanded;
                if (_isViewMenuExpanded) {
                  _isSortMenuExpanded = false;
                  _isLanguageMenuExpanded = false;
                }
              });
            },
            backgroundColor: const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.view_module,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          // Language button
          FloatingActionButton(
            mini: true,
            heroTag: "language",
            onPressed: () {
              setState(() {
                _isLanguageMenuExpanded = !_isLanguageMenuExpanded;
                if (_isLanguageMenuExpanded) {
                  _isSortMenuExpanded = false;
                  _isViewMenuExpanded = false;
                }
              });
            },
            backgroundColor: const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.language,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          // Sort button
          FloatingActionButton(
            mini: true,
            heroTag: "sort",
            onPressed: () {
              setState(() {
                _isSortMenuExpanded = !_isSortMenuExpanded;
                if (_isSortMenuExpanded) {
                  _isViewMenuExpanded = false;
                  _isLanguageMenuExpanded = false;
                }
              });
            },
            backgroundColor: const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.sort,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSortingMenu() {
    return Positioned(
      bottom: 122,
      right: 72,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "alphabetical",
            onPressed: () {
              setState(() {
                _currentSort = SortType.alphabetical;
                _isSortMenuExpanded = false;
              });
            },
            backgroundColor: _currentSort == SortType.alphabetical 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.sort_by_alpha,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "seasonal",
            onPressed: () {
              setState(() {
                _currentSort = SortType.seasonal;
                _isSortMenuExpanded = false;
              });
            },
            backgroundColor: _currentSort == SortType.seasonal 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "favorite",
            onPressed: () {
              setState(() {
                _currentSort = SortType.favorite;
                _isSortMenuExpanded = false;
              });
            },
            backgroundColor: _currentSort == SortType.favorite 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<ProduceItem> _sortItems(List<ProduceItem> items) {
    switch (_currentSort) {
      case SortType.alphabetical:
        return List.from(items)..sort((a, b) => a.name.compareTo(b.name));
      case SortType.seasonal:
        return List.from(items)..sort((a, b) => _compareSeasonalPriority(a, b));
      case SortType.favorite:
        return List.from(items)..sort((a, b) => _compareFavoritePriority(a, b));
      case SortType.none:
      return items;
    }
  }

  int _compareSeasonalPriority(ProduceItem a, ProduceItem b) {
    if (_selectedLocation == null) return 0;
    
    int currentMonth = DateTime.now().month;
    List<int> aSeason = a.seasonalAvailability[_selectedLocation!] ?? [];
    List<int> bSeason = b.seasonalAvailability[_selectedLocation!] ?? [];
    
    // Calculate how close to the center of their season each item is (peak season)
    double aPeakScore = _calculatePeakSeasonScore(aSeason, currentMonth);
    double bPeakScore = _calculatePeakSeasonScore(bSeason, currentMonth);
    
    // Higher peak score comes first
    return bPeakScore.compareTo(aPeakScore);
  }

  double _calculatePeakSeasonScore(List<int> seasonMonths, int currentMonth) {
    if (seasonMonths.isEmpty) return 0.0;
    
    // If only one month, and it's current month, it's peak season
    if (seasonMonths.length == 1) {
      return seasonMonths.contains(currentMonth) ? 1.0 : 0.0;
    }
    
    // For multiple months, find the middle of the season
    List<int> sortedMonths = List.from(seasonMonths)..sort();
    
    // Handle seasons that wrap around the year (e.g., Nov-Jan)
    if (sortedMonths.last - sortedMonths.first > 6) {
      // Season spans across year boundary
      int midMonth = _findWrappedSeasonMiddle(sortedMonths);
      return _distanceFromPeak(currentMonth, midMonth.toDouble());
    } else {
      // Normal season within the year
      double midMonth = (sortedMonths.first + sortedMonths.last) / 2.0;
      return _distanceFromPeak(currentMonth, midMonth);
    }
  }

  int _findWrappedSeasonMiddle(List<int> months) {
    // For seasons like [1,2,3,11,12], find middle of the wrapped season
    List<int> earlyMonths = months.where((m) => m <= 6).toList();
    List<int> lateMonths = months.where((m) => m > 6).toList();
    
    if (earlyMonths.isNotEmpty && lateMonths.isNotEmpty) {
      // Season wraps around year
      int spanStart = lateMonths.first;
      int spanEnd = earlyMonths.last + 12; // Adjust to next year
      return ((spanStart + spanEnd) / 2).round() % 12;
    }
    
    return months.first;
  }

  double _distanceFromPeak(int currentMonth, double peakMonth) {
    double distance = (currentMonth - peakMonth).abs();
    // Convert distance to score (closer to peak = higher score)
    return 1.0 - (distance / 6.0).clamp(0.0, 1.0);
  }

  void toggleFavorite(String itemName) {
    setState(() {
      if (_favorites.contains(itemName)) {
        _favorites.remove(itemName);
      } else {
        _favorites.add(itemName);
      }
    });
    _savePreferences();
  }

  bool isFavorite(String itemName) {
    return _favorites.contains(itemName);
  }

  void _flipCard(String itemKey) {
    if (_flipControllers[itemKey]!.value == 0) {
      _flipControllers[itemKey]!.forward();
    } else {
      _flipControllers[itemKey]!.reverse();
      // Reset detailed nutrition state when flipping back to front
      setState(() {
        final itemName = itemKey.split('_')[0]; // Extract item name from key
        _showDetailedNutrition[itemName] = false;
      });
    }
  }

  Widget _buildFrontCard(ProduceItem item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                  bottom: Radius.circular(15),
                ),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 250,
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () => toggleFavorite(item.name),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      isFavorite(item.name) ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite(item.name) ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              fontFamily: 'BebasNeue',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionCard(ProduceItem item) {
    final nutrition = item.nutritionInfo;
    final isDetailedView = _showDetailedNutrition[item.name] ?? false;
    
    // No special handling for detailed view - just use regular card
    
    Widget cardContent = Container(
        height: isDetailedView ? 500 : 300,
        decoration: BoxDecoration(
          color: const Color(0xFFD6FFEE),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: const Color(0xFF3B0D3A), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isDetailedView ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showDetailedNutrition[item.name] = false;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Color(0xFF240041),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${item.name} - ${AppLocalizations.of(context)!.nutrition}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue',
                        color: Color(0xFF240041),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              Expanded(child: _buildDetailedNutritionView(item)),
            ],
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${item.name} - ${AppLocalizations.of(context)!.nutrition}',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BebasNeue',
                  color: Color(0xFF240041),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                '${nutrition.calories} ${AppLocalizations.of(context)!.kcal}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF240041),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: _buildNutrientDensityCircle(nutrition, Colors.orange),
                  ),
                  SizedBox(
                    width: 100,
                    child: _buildFiberCircle(nutrition.fiber ?? 2.0, Colors.brown),
                  ),
                  SizedBox(
                    width: 100,
                    child: _buildKeyVitaminsCircle(nutrition, Colors.purple),
                  ),
                ],
              ),
              if (nutrition.detailedInfo != null) ...[
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showDetailedNutrition[item.name] = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF74ce9e),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(AppLocalizations.of(context)!.detailedNutrition),
                ),
              ],
            ],
          ),
        ),
      );
    
    // Only apply flip transform if not showing detailed nutrition
    if (isDetailedView) {
      return cardContent;
    } else {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(math.pi),
        child: cardContent,
      );
    }
  }


  Widget _buildNutrientDensityCircle(NutritionInfo nutrition, Color color) {
    // Calculate RDI-to-Calorie score
    double totalRDI = 0.0;
    
    if (nutrition.detailedInfo != null) {
      final detailed = nutrition.detailedInfo!;
      // Calculate RDI percentages for all nutrients
      totalRDI += (nutrition.carbs / _driValues['carbs']!) * 100;
      totalRDI += ((nutrition.fiber ?? 2.0) / _driValues['fiber']!) * 100;
      totalRDI += (detailed.vitaminA / _driValues['vitaminA']!) * 100;
      totalRDI += (detailed.vitaminC / _driValues['vitaminC']!) * 100;
      totalRDI += (detailed.vitaminK / _driValues['vitaminK']!) * 100;
      totalRDI += (detailed.vitaminE / _driValues['vitaminE']!) * 100;
      totalRDI += (detailed.folate / _driValues['folate']!) * 100;
      totalRDI += (detailed.potassium / _driValues['potassium']!) * 100;
      totalRDI += (detailed.calcium / _driValues['calcium']!) * 100;
      totalRDI += (detailed.magnesium / _driValues['magnesium']!) * 100;
      totalRDI += (detailed.phosphorus / _driValues['phosphorus']!) * 100;
      totalRDI += (detailed.iron / _driValues['iron']!) * 100;
    } else {
      // Basic calculation for items without detailed info
      totalRDI += (nutrition.carbs / _driValues['carbs']!) * 100;
      totalRDI += ((nutrition.fiber ?? 2.0) / _driValues['fiber']!) * 100;
      totalRDI += (nutrition.fats / _driValues['fats']!) * 100;
      totalRDI += (nutrition.proteins / _driValues['proteins']!) * 100;
    }
    
    // Calculate RDI per calorie
    final rdiPerCalorie = nutrition.calories > 0 ? totalRDI / nutrition.calories : 0.0;
    
    // Convert to 1-10 scale (stricter: 1.0% RDI per calorie = 2.5/10, 4.0% = 10/10)
    final densityScore = (rdiPerCalorie * 2.5).clamp(0.0, 10.0);
    
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.2),
                ),
                child: Center(
                  child: Text(
                    densityScore.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.nutrientDensity,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF240041),
          ),
        ),
        Text(
          '${densityScore.toStringAsFixed(1)}/10',
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF240041),
          ),
        ),
      ],
    );
  }

  Widget _buildFiberCircle(double fiberValue, Color color) {
    // Calculate percentage of daily recommended fiber (25g for adults)
    final dailyRecommendedFiber = 25.0;
    final percentage = (fiberValue / dailyRecommendedFiber * 100).clamp(0.0, 100.0);
    
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.2),
                ),
                child: Center(
                  child: Text(
                    '${fiberValue.toStringAsFixed(1)}g',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.fiber,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF240041),
          ),
        ),
        Text(
          '${percentage.toInt()}% DRI',
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF240041),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyVitaminsCircle(NutritionInfo nutrition, Color color) {
    String topVitaminName = 'N/A';
    double topVitaminPercentage = 0.0;
    
    if (nutrition.detailedInfo != null) {
      final detailed = nutrition.detailedInfo!;
      
      // Calculate RDI percentages for each vitamin
      final vitaminPercentages = {
        'Vit C': (detailed.vitaminC / _driValues['vitaminC']!) * 100,
        'Vit A': (detailed.vitaminA / _driValues['vitaminA']!) * 100,
        'Vit K': (detailed.vitaminK / _driValues['vitaminK']!) * 100,
        'Vit E': (detailed.vitaminE / _driValues['vitaminE']!) * 100,
        'Folate': (detailed.folate / _driValues['folate']!) * 100,
      };
      
      // Find the vitamin with highest RDI percentage
      vitaminPercentages.forEach((name, percentage) {
        if (percentage > topVitaminPercentage) {
          topVitaminPercentage = percentage;
          topVitaminName = name;
        }
      });
    }
    
    return Column(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.2),
                ),
                child: Center(
                  child: Text(
                    topVitaminPercentage > 0 ? '${topVitaminPercentage.toStringAsFixed(1)}%' : 'N/A',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          topVitaminName,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF240041),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.dri,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF240041),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedNutritionView(ProduceItem item) {
    final detailed = item.nutritionInfo.detailedInfo!;
    
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Text(
              AppLocalizations.of(context)!.vitamins,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
            const SizedBox(height: 10),
            _buildNutrientHeader(),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminA, detailed.vitaminA, AppLocalizations.of(context)!.mcg, _driValues['vitaminA']!),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminC, detailed.vitaminC, AppLocalizations.of(context)!.mg, _driValues['vitaminC']!),
            if (detailed.vitaminD != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminD, detailed.vitaminD!, AppLocalizations.of(context)!.mcg, _driValues['vitaminD'] ?? 20.0),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminE, detailed.vitaminE, AppLocalizations.of(context)!.mg, _driValues['vitaminE']!),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminK, detailed.vitaminK, AppLocalizations.of(context)!.mcg, _driValues['vitaminK']!),
            if (detailed.thiamin != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.thiamin, detailed.thiamin!, AppLocalizations.of(context)!.mg, _driValues['thiamin'] ?? 1.1),
            if (detailed.riboflavin != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.riboflavin, detailed.riboflavin!, AppLocalizations.of(context)!.mg, _driValues['riboflavin'] ?? 1.4),
            if (detailed.niacin != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.niacin, detailed.niacin!, AppLocalizations.of(context)!.mg, _driValues['niacin'] ?? 16.0),
            if (detailed.vitaminB6 != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminB6, detailed.vitaminB6!, AppLocalizations.of(context)!.mg, _driValues['vitaminB6'] ?? 1.4),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.folate, detailed.folate, AppLocalizations.of(context)!.mcg, _driValues['folate']!),
            if (detailed.vitaminB12 != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.vitaminB12, detailed.vitaminB12!, AppLocalizations.of(context)!.mcg, _driValues['vitaminB12'] ?? 2.4),
            
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.minerals,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
            const SizedBox(height: 10),
            _buildNutrientHeader(),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.potassium, detailed.potassium, AppLocalizations.of(context)!.mg, _driValues['potassium']!),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.calcium, detailed.calcium, AppLocalizations.of(context)!.mg, _driValues['calcium']!),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.magnesium, detailed.magnesium, AppLocalizations.of(context)!.mg, _driValues['magnesium']!),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.phosphorus, detailed.phosphorus, AppLocalizations.of(context)!.mg, _driValues['phosphorus']!),
            _buildNutrientRowWithDRI(AppLocalizations.of(context)!.iron, detailed.iron, AppLocalizations.of(context)!.mg, _driValues['iron']!),
            if (detailed.zinc != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.zinc, detailed.zinc!, AppLocalizations.of(context)!.mg, _driValues['zinc'] ?? 10.0),
            if (detailed.sodium != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.sodium, detailed.sodium!, AppLocalizations.of(context)!.mg, _driValues['sodium'] ?? 2300.0),
            if (detailed.selenium != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.selenium, detailed.selenium!, AppLocalizations.of(context)!.mcg, _driValues['selenium'] ?? 55.0),
            if (detailed.iodine != null)
              _buildNutrientRowWithDRI(AppLocalizations.of(context)!.iodine, detailed.iodine!, AppLocalizations.of(context)!.mcg, _driValues['iodine'] ?? 150.0),
            
            const SizedBox(height: 20),
            Text(
              'Macronutrients',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
            const SizedBox(height: 10),
            _buildMacroNutrientHeader(),
            _buildCarbsMainRow(item.nutritionInfo.carbs),
            if (item.nutritionInfo.fiber != null)
              _buildCarbsSubRow('Fiber', item.nutritionInfo.fiber!, 'g'),
            if (detailed.sugar != null)
              _buildCarbsSubRow('Sugar', detailed.sugar!, 'g'),
            if (detailed.starch != null)
              _buildCarbsSubRow('Starch', detailed.starch!, 'g'),
            _buildMacroNutrientRow('Fats', item.nutritionInfo.fats, 'g'),
            _buildMacroNutrientRow('Proteins', item.nutritionInfo.proteins, 'g'),
            
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.water,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
            const SizedBox(height: 10),
            _buildWaterRow(AppLocalizations.of(context)!.amount, detailed.water, 'g'),
            
        ],
      ),
    );
  }


  Widget _buildNutrientHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              AppLocalizations.of(context)!.nutrient,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              AppLocalizations.of(context)!.amount,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '%${AppLocalizations.of(context)!.dri}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientRowWithDRI(String name, double value, String unit, double driValue) {
    final percentage = driValue > 0 ? (value / driValue * 100) : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${value.toStringAsFixed(value >= 1 ? 1 : 2)}$unit',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: percentage >= 10 ? const Color(0xFF74ce9e) : const Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroNutrientHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              'Nutrient',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: Text(
              'Amount',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '%${AppLocalizations.of(context)!.dri}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroNutrientRow(String name, double value, String unit) {
    final driKey = name.toLowerCase();
    final driValue = _driValues[driKey] ?? 1.0;
    final percentage = driValue > 0 ? (value / driValue * 100) : 0.0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${value.toStringAsFixed(value >= 1 ? 1 : 2)}$unit',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: percentage >= 10 ? const Color(0xFF74ce9e) : const Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterRow(String name, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${value.toStringAsFixed(value >= 1 ? 1 : 2)}$unit',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildCarbsMainRow(double carbValue) {
    final driValue = _driValues['carbs'] ?? 1.0;
    final percentage = driValue > 0 ? (carbValue / driValue * 100) : 0.0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Carbs',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${carbValue.toStringAsFixed(carbValue >= 1 ? 1 : 2)}g',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF240041),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: percentage >= 10 ? const Color(0xFF74ce9e) : const Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarbsSubRow(String name, double value, String unit) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 2.0, bottom: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '• $name',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${value.toStringAsFixed(value >= 1 ? 1 : 2)}$unit',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // DRI values for adults (average of male/female recommendations)
  Map<String, double> get _driValues => {
    'vitaminA': 750.0, // mcg
    'vitaminC': 80.0, // mg
    'vitaminK': 70.0, // mcg
    'vitaminE': 12.0, // mg
    'folate': 400.0, // mcg
    'potassium': 3500.0, // mg
    'calcium': 1000.0, // mg
    'magnesium': 350.0, // mg
    'phosphorus': 700.0, // mg
    'iron': 14.0, // mg
    'carbs': 250.0, // g (same as used in circles)
    'fats': 65.0, // g (20-35% of 2000 kcal = ~44-78g, using middle value)
    'proteins': 50.0, // g (0.8g per kg for 70kg adult = 56g, rounded to 50g)
    'fiber': 25.0, // g (same as used in circles)
  };

  Widget _buildViewMenu() {
    return Positioned(
      bottom: 234,
      right: 72,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "list_view",
            onPressed: () {
              setState(() {
                _viewType = ViewType.list;
                _isViewMenuExpanded = false;
              });
            },
            backgroundColor: _viewType == ViewType.list 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "grid_view",
            onPressed: () {
              setState(() {
                _viewType = ViewType.icon;
                _isViewMenuExpanded = false;
              });
            },
            backgroundColor: _viewType == ViewType.icon 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.grid_view,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "card_view",
            onPressed: () {
              setState(() {
                _viewType = ViewType.card;
                _isViewMenuExpanded = false;
              });
            },
            backgroundColor: _viewType == ViewType.card 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Icon(
              Icons.view_agenda,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageMenu() {
    return Positioned(
      bottom: 178,
      right: 72,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: "swedish",
            onPressed: () {
              setState(() {
                _selectedLanguage = "swedish";
                _isLanguageMenuExpanded = false;
              });
              widget.onLocaleChange(const Locale('sv'));
              _savePreferences();
            },
            backgroundColor: _selectedLanguage == "swedish" 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Text(
              'SV',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "english",
            onPressed: () {
              setState(() {
                _selectedLanguage = "english";
                _isLanguageMenuExpanded = false;
              });
              widget.onLocaleChange(const Locale('en'));
              _savePreferences();
            },
            backgroundColor: _selectedLanguage == "english" 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Text(
              'EN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            mini: true,
            heroTag: "spanish",
            onPressed: () {
              setState(() {
                _selectedLanguage = "spanish";
                _isLanguageMenuExpanded = false;
              });
              widget.onLocaleChange(const Locale('es'));
              _savePreferences();
            },
            backgroundColor: _selectedLanguage == "spanish" 
                ? const Color(0xFF74ce9e) 
                : const Color(0xFF3B0D3A),
            child: const Text(
              'ES',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _compareFavoritePriority(ProduceItem a, ProduceItem b) {
    bool aIsFavorite = isFavorite(a.name);
    bool bIsFavorite = isFavorite(b.name);
    
    // If both are favorites or both are not favorites, sort alphabetically
    if (aIsFavorite == bIsFavorite) {
      return a.name.compareTo(b.name);
    }
    
    // Favorites come first
    return aIsFavorite ? -1 : 1;
  }
}