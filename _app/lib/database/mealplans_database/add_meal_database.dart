import 'package:hive_flutter/hive_flutter.dart';

class MealFieldDB {
  static const String _boxName = 'admin_meal_fields';

  /// Get enabled fields from Hive
  static Future<Map<String, bool>> getEnabledFields() async {
    final box = await Hive.openBox(_boxName);
    final rawFields = box.get('fieldsEnabled', defaultValue: {});
    final Map<String, dynamic> fields = Map<String, dynamic>.from(rawFields);

    return {
      'protein': fields['protein'] ?? false,
      'carbs': fields['carbs'] ?? false,
      'fats': fields['fats'] ?? false,
      'calories': fields['calories'] ?? false,
    };
  }
}
