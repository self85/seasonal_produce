// produce_item.dart

class NutritionInfo {
  final double carbs; // grams per 100g
  final double fats; // grams per 100g
  final double proteins; // grams per 100g
  final int calories; // calories per 100g

  NutritionInfo({
    required this.carbs,
    required this.fats,
    required this.proteins,
    required this.calories,
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
