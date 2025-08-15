// produce_item.dart

class ProduceItem {
  final String name;
  final String imagePath;
  final Map<String, List<int>> seasonalAvailability; // Availability per country and month

  // Constructor
  ProduceItem(this.name, this.imagePath, this.seasonalAvailability);

  // Check if the produce item is in season for the selected country and current month
  bool isInSeason(String country, int month) {
    return seasonalAvailability[country]?.contains(month) ?? false;
  }
}
