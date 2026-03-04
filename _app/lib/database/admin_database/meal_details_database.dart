import 'package:hive_flutter/hive_flutter.dart';

class AdminMealFieldsDB {
  static const String _boxName = 'admin_meal_fields';

  /// ✅ Open or return Hive box
  static Future<Box> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox(_boxName);
    }
    return Hive.box(_boxName);
  }

  /// ✅ Save meal fields as enabled
  static Future<void> saveMealFields() async {
    final box = await openBox();
    await box.put('isSaved', true);
    await box.put('fieldsEnabled', {
      'protein': true,
      'carbs': true,
      'fats': true,
      'calories': true,
    });
  }

  /// ✅ Get saved meal field status
  static Future<bool> getFieldsStatus() async {
    final box = await openBox();
    return box.get('isSaved', defaultValue: false);
  }

  /// ✅ Delete all fields
  static Future<void> deleteFields() async {
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
