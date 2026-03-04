import 'package:hive_flutter/hive_flutter.dart';

/// 🌐 Base class ONLY for Weight Loss
abstract class BaseMealDatabaseWeightLoss {
  Box? _mealsBox;
  String? currentUserId;
  bool isInitialized = false;

  final String category;
  final String mealType;

  BaseMealDatabaseWeightLoss(this.category, this.mealType);

  Box get box => _mealsBox!;

  Future<void> init(String? adminCategoryName) async {
    await Hive.initFlutter();

    var sessionBox = await Hive.openBox('session');
    currentUserId = sessionBox.get('currentUserId') ?? 'defaultUser';

    // 🔥 Unique box per admin category
    String boxName = adminCategoryName != null
        ? '${category}_${currentUserId}_admin_${adminCategoryName}'
        : '${category}_${currentUserId}_${mealType}Meals';

    _mealsBox = await Hive.openBox(boxName);
    isInitialized = true;
  }

  Future<void> addMeal(Map<String, String> meal) async {
    await _mealsBox!.add(meal);
  }

  Future<void> updateMeal(int index, Map<String, String> meal) async {
    await _mealsBox!.putAt(index, meal);
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
}

/// 🧩 Admin Added – Weight Loss (MULTIPLE categories supported)
class AdminAddedMealsWeightLossDatabase extends BaseMealDatabaseWeightLoss {
  final String adminCategoryName;

  AdminAddedMealsWeightLossDatabase(this.adminCategoryName)
      : super('weightloss', 'adminAdded');

  Future<void> initDB() async {
    await init(adminCategoryName);
  }
}

/// 🥣 Breakfast – Weight Loss
class BreakfastWeightLossDatabase extends BaseMealDatabaseWeightLoss {
  BreakfastWeightLossDatabase() : super('weightloss', 'breakfast');

  Future<void> initDB() async => await init(null);
}

/// 🍛 Lunch – Weight Loss
class LunchWeightLossDatabase extends BaseMealDatabaseWeightLoss {
  LunchWeightLossDatabase() : super('weightloss', 'lunch');

  Future<void> initDB() async => await init(null);
}

/// 🍲 Dinner – Weight Loss
class DinnerWeightLossDatabase extends BaseMealDatabaseWeightLoss {
  DinnerWeightLossDatabase() : super('weightloss', 'dinner');

  Future<void> initDB() async => await init(null);
}
