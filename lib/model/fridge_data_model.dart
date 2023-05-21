import 'package:flutter/material.dart';

class FridgeDataModel {
  List<String>? food = [''];
  final DateTime? date;
  int? foodChangeTimeMinute;

  FridgeDataModel(
      {required this.food,
      required this.date,
      required this.foodChangeTimeMinute});

  factory FridgeDataModel.fromJson(Map<dynamic, dynamic> json) {
    debugPrint('x1');
    final foodList = json['food'] != null
        ? List<String>.from(json['food'] as List<dynamic>)
        : [''];
    debugPrint('x2');
    final dateMap = json['date'] as Map<dynamic, dynamic>?;
    debugPrint('x3');

    final year = dateMap != null ? int.parse(dateMap['year']) : 0;
    final month = dateMap != null ? int.parse(dateMap['month']) : 0;
    final day = dateMap != null ? int.parse(dateMap['day']) : 0;
    final hour = dateMap != null ? int.parse(dateMap['hour']) : 0;
    final minute = dateMap != null ? int.parse(dateMap['minute']) : 0;
    final second = dateMap != null ? int.parse(dateMap['second']) : 0;
    debugPrint('x4');
    final date = DateTime(year, month, day, hour, minute, second);
    debugPrint('x5');

    final foodChangeTimeMinute = json['foodChangeTimeMinute'] != null
        ? int.parse(json['foodChangeTimeMinute'].toString())
        : null;

    debugPrint('x6');
    return FridgeDataModel(
      food: foodList,
      date: date,
      foodChangeTimeMinute: foodChangeTimeMinute,
    );
  }
}
