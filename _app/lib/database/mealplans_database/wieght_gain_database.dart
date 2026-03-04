import 'package:hive_flutter/hive_flutter.dart';

/// 🌐 Base class ONLY for Weight Gain
abstract class BaseMealDatabaseWeightGain {
  Box? _mealsBox;
  String? currentUserId;
  bool isInitialized = false;

  final String category; // "weightgain"
  final String mealType; // breakfast / lunch / dinner / adminAdded

  BaseMealDatabaseWeightGain(this.category, this.mealType);

  Box get box => _mealsBox!;

  /// Initialize database box
  Future<void> init(String? adminCategoryName) async {
    await Hive.initFlutter();

    // Get current user ID
    var sessionBox = await Hive.openBox('session');
    currentUserId = sessionBox.get('currentUserId') ?? 'defaultUser';

    // 🔥 Unique BOX per admin category
    String boxName = adminCategoryName != null
        ? '${category}_${currentUserId}_admin_${adminCategoryName}'
        : '${category}_${currentUserId}_${mealType}Meals';

    _mealsBox = await Hive.openBox(boxName);
    isInitialized = true;
  }

  /// Add meal
  Future<void> addMeal(Map<String, String> meal) async {
    await _mealsBox!.add(meal);
  }

  /// Update meal
  Future<void> updateMeal(int index, Map<String, String> meal) async {
    await _mealsBox!.putAt(index, meal);
  }

  /// Delete meal
  Future<void> deleteMeal(int index) async {
    await _mealsBox!.deleteAt(index);
  }

  /// Get all meals
  List<Map<String, String>> getAllMeals() {
    return _mealsBox!.values
        .cast<Map>()
        .map((e) => Map<String, String>.from(e))
        .toList();
  }
}

/// 🧩 Admin Added – Weight Gain (MULTIPLE categories supported)
class AdminAddedMealsWeightGainDatabase extends BaseMealDatabaseWeightGain {
  final String adminCategoryName;

  AdminAddedMealsWeightGainDatabase(this.adminCategoryName)
      : super('weightgain', 'adminAdded');

  /// Initialize unique admin category box
  Future<void> initDB() async {
    await init(adminCategoryName);
  }
}

/// 🥣 Breakfast – Weight Gain
class BreakfastWeightGainDatabase extends BaseMealDatabaseWeightGain {
  BreakfastWeightGainDatabase() : super('weightgain', 'breakfast');

  Future<void> initDB() async => await init(null);
}

/// 🍛 Lunch – Weight Gain
class LunchWeightGainDatabase extends BaseMealDatabaseWeightGain {
  LunchWeightGainDatabase() : super('weightgain', 'lunch');

  Future<void> initDB() async => await init(null);
}

/// 🍲 Dinner – Weight Gain
class DinnerWeightGainDatabase extends BaseMealDatabaseWeightGain {
  DinnerWeightGainDatabase() : super('weightgain', 'dinner');

  Future<void> initDB() async => await init(null);
}
