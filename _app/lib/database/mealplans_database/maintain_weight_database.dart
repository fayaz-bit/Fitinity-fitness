import 'package:hive_flutter/hive_flutter.dart';

/// 🌐 Base class ONLY for Maintain Weight
abstract class BaseMealDatabaseMaintain {
  Box? _mealsBox;
  String? currentUserId;
  bool isInitialized = false;

  final String category;
  final String mealType;

  BaseMealDatabaseMaintain(this.category, this.mealType);

  Box get box => _mealsBox!;

  Future<void> init() async {
    await Hive.initFlutter();
    var sessionBox = await Hive.openBox('session');
    currentUserId = sessionBox.get('currentUserId') ?? 'defaultUser';

    String boxName = '${category}_${currentUserId}_${mealType}Meals';
    _mealsBox = await Hive.openBox(boxName);
    isInitialized = true;
  }

  Future<void> addMeal(Map<String, String> meal) async {
    await _mealsBox!.add(_sanitize(meal));
  }

  Future<void> updateMeal(int index, Map<String, String> meal) async {
    await _mealsBox!.putAt(index, _sanitize(meal));
  }

  Future<void> deleteMeal(int index) async {
    await _mealsBox!.deleteAt(index);
  }

  List<Map<String, String>> getAllMeals() {
    return _mealsBox!.values
        .cast<Map>()
        .map((e) => Map<String, String>.from(e))
        .toList();
  }

  Map<String, String> _sanitize(Map<String, String> m) {
    return {
      'name': m['name'] ?? '',
      'description': m['description'] ?? '',
      'protein': m['protein'] ?? '',
      'carbs': m['carbs'] ?? '',
      'fat': m['fat'] ?? '',
      'calories': m['calories'] ?? '',
      'ingredients': m['ingredients'] ?? '',
      'preparation': m['preparation'] ?? '',
    };
  }
}

/// 🥣 Maintain Weight – Breakfast
class BreakfastDatabase extends BaseMealDatabaseMaintain {
  BreakfastDatabase() : super('maintainweight', 'breakfast');
}

/// 🍛 Maintain Weight – Lunch
class LunchDatabase extends BaseMealDatabaseMaintain {
  LunchDatabase() : super('maintainweight', 'lunch');
}

/// 🍲 Maintain Weight – Dinner
class DinnerDatabase extends BaseMealDatabaseMaintain {
  DinnerDatabase() : super('maintainweight', 'dinner');
}
