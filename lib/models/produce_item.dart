// produce_item.dart

class DetailedNutritionInfo {
  final double saturatedFat; // grams per 100g
  final double monounsaturatedFat; // grams per 100g
  final double polyunsaturatedFat; // grams per 100g
  final double vitaminA; // mcg per 100g
  final double vitaminC; // mg per 100g
  final double vitaminK; // mcg per 100g
  final double vitaminE; // mg per 100g
  final double folate; // mcg per 100g
  final double potassium; // mg per 100g
  final double calcium; // mg per 100g
  final double magnesium; // mg per 100g
  final double phosphorus; // mg per 100g
  final double iron; // mg per 100g

  DetailedNutritionInfo({
    required this.saturatedFat,
    required this.monounsaturatedFat,
    required this.polyunsaturatedFat,
    required this.vitaminA,
    required this.vitaminC,
    required this.vitaminK,
    required this.vitaminE,
    required this.folate,
    required this.potassium,
    required this.calcium,
    required this.magnesium,
    required this.phosphorus,
    required this.iron,
  });
}

class NutritionInfo {
  final double carbs; // grams per 100g
  final double fats; // grams per 100g
  final double proteins; // grams per 100g
  final double? fiber; // grams per 100g
  final int calories; // calories per 100g
  final DetailedNutritionInfo? detailedInfo; // Optional detailed nutrition

  NutritionInfo({
    required this.carbs,
    required this.fats,
    required this.proteins,
    this.fiber,
    required this.calories,
    this.detailedInfo,
  });
}

class ProduceItem {
  final String name;
  final String imagePath;
  final Map<String, List<int>> seasonalAvailability; // Availability per country and month
  final NutritionInfo nutritionInfo;

  // Constructor
  ProduceItem(this.name, this.imagePath, this.seasonalAvailability, this.nutritionInfo);

  // Check if the produce item is in season for the selected country and current month
  bool isInSeason(String country, int month) {
    return seasonalAvailability[country]?.contains(month) ?? false;
  }
}
