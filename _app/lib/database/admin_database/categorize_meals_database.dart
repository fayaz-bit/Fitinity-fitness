import 'package:hive_flutter/hive_flutter.dart';
import 'package:_app/models/meal_model.dart';

class MealCategoryDB {
  static const String _boxName = 'meal_categories';

  /// ✅ Open or return existing Hive box
  static Future<Box<MealCategory>> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<MealCategory>(_boxName);
    }
    return Hive.box<MealCategory>(_boxName);
  }

  /// ✅ Add a new meal category (with duplicate check)
  static Future<String> addCategory(MealCategory category) async {
    final box = await openBox();

    final duplicate = box.values.any(
      (c) => c.name.trim().toLowerCase() == category.name.trim().toLowerCase(),
    );

    if (duplicate) return "duplicate";

    await box.add(category);
    return "added";
  }

  /// ✅ Delete a category by index
  static Future<void> deleteCategory(int index) async {
    final box = await openBox();
    if (index < box.length) await box.deleteAt(index);
  }

  /// ✅ Get all meal categories
  static Future<List<MealCategory>> getAllCategories() async {
    final box = await openBox();
    return box.values.toList();
  }

  /// ✅ Clear all categories
  static Future<void> clearAll() async {
    final box = await openBox();
    await box.clear();
  }

  /// ✅ Close box safely
  static Future<void> closeBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      await Hive.box(_boxName).close();
    }
  }
}
