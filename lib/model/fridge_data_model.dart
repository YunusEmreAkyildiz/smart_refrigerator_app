// To parse this JSON data, do
//
//     final fridgeDataModel = fridgeDataModelFromMap(jsonString);
/*
class FridgeDataModel {
  final List<String> food;
  final String date;

  FridgeDataModel({
    required this.food,
    required this.date,
  });

  // static FridgeDataModel fromJson(json) =>
  //     FridgeDataModel(food: json['food'], date: json['date']);

  static FridgeDataModel fromJson(Map<String, dynamic> json) {
    return FridgeDataModel(
      food: List<String>.from(json['food']),
      date: json['date'],
    );
  }

  //String toJson() => json.encode(toMap());

  factory FridgeDataModel.fromMap(Map<String, dynamic> json) => FridgeDataModel(
        food: List<String>.from(json["food"].map((x) => x)),
        date: json["date"],
      );

  // Map<String, dynamic> toMap() => {
  //     "Food": List<dynamic>.from(food.map((x) => x)),
  //     "Date": date,
  // };
}
*/

class FridgeDataModel {
  final List<String> food;
  final DateTime date;

  FridgeDataModel({
    required this.food,
    required this.date,
  });

  factory FridgeDataModel.fromJson(Map<String, dynamic> json) {
    final foodList = List<String>.from(json['food']);
    final dateMap = json['date'] as Map<String, dynamic>;

    final year = int.parse(dateMap['year']);
    final month = int.parse(dateMap['month']);
    final day = int.parse(dateMap['day']);
    final hour = int.parse(dateMap['hour']);
    final minute = int.parse(dateMap['minute']);
    final second = int.parse(dateMap['second']);

    final date = DateTime(year, month, day, hour, minute, second);

    return FridgeDataModel(food: foodList, date: date);
  }
}
