// produce_item.dart

class DetailedNutritionInfo {
  final double saturatedFat; // grams per 100g
  final double monounsaturatedFat; // grams per 100g
  final double polyunsaturatedFat; // grams per 100g
  final double? sugar; // grams per 100g
  final double? starch; // grams per 100g
  final double water; // grams per 100g
  
  // Vitamins
  final double vitaminA; // RE per 100g
  final double vitaminC; // mg per 100g
  final double vitaminK; // mcg per 100g
  final double vitaminE; // mg per 100g
  final double? vitaminD; // mcg per 100g
  final double folate; // mcg per 100g
  final double? vitaminB6; // mg per 100g
  final double? vitaminB12; // mcg per 100g
  final double? thiamin; // mg per 100g (B1)
  final double? riboflavin; // mg per 100g (B2)
  final double? niacin; // mg per 100g (B3)
  
  // Minerals
  final double potassium; // mg per 100g
  final double calcium; // mg per 100g
  final double magnesium; // mg per 100g
  final double phosphorus; // mg per 100g
  final double iron; // mg per 100g
  final double? zinc; // mg per 100g
  final double? sodium; // mg per 100g
  final double? selenium; // mcg per 100g
  final double? iodine; // mcg per 100g

  DetailedNutritionInfo({
    required this.saturatedFat,
    required this.monounsaturatedFat,
    required this.polyunsaturatedFat,
    this.sugar,
    this.starch,
    required this.water,
    
    // Vitamins
    required this.vitaminA,
    required this.vitaminC,
    required this.vitaminK,
    required this.vitaminE,
    this.vitaminD,
    required this.folate,
    this.vitaminB6,
    this.vitaminB12,
    this.thiamin,
    this.riboflavin,
    this.niacin,
    
    // Minerals
    required this.potassium,
    required this.calcium,
    required this.magnesium,
    required this.phosphorus,
    required this.iron,
    this.zinc,
    this.sodium,
    this.selenium,
    this.iodine,
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
