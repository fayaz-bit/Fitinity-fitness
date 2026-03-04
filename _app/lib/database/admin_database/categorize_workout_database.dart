import 'package:hive_flutter/hive_flutter.dart';
import 'package:_app/models/admin_model.dart';

class AdminWorkoutCategoryDB {
  static const String _boxName = 'admin_workouts';

  /// ✅ Open Hive box (creates if needed)
  static Future<Box<AdminWorkoutCategory>> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<AdminWorkoutCategory>(_boxName);
    }
    return Hive.box<AdminWorkoutCategory>(_boxName);
  }

  /// ✅ Add new category (with duplicate check)
  static Future<String> addCategory(AdminWorkoutCategory category) async {
    final box = await openBox();

    // Prevent duplicate names (case-insensitive)
    final duplicate = box.values.any(
      (cat) => cat.name.toLowerCase() == category.name.toLowerCase(),
    );

    if (duplicate) {
      return "duplicate";
    }

    await box.add(category);
    return "added";
  }

  /// ✅ Delete category by index
  static Future<void> deleteCategory(int index) async {
    final box = await openBox();
    if (index < box.length) {
      await box.deleteAt(index);
    }
  }

  /// ✅ Get all categories
  static Future<List<AdminWorkoutCategory>> getAllCategories() async {
    final box = await openBox();
    return box.values.toList();
  }

  /// ✅ Clear all categories
  static Future<void> clearAll() async {
    final box = await openBox();
    await box.clear();
  }

  /// ✅ Close the Hive box
  static Future<void> closeBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      await Hive.box(_boxName).close();
    }
  }
}
