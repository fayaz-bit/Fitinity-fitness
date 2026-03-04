import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  /// Get current user ID from session
  static Future<String?> getCurrentUserId() async {
    final sessionBox = await Hive.openBox('session');
    return sessionBox.get('currentUserId');
  }

  static Future<Box> openCategoryWorkoutsBox(
      String userId, String categoryName) async {
    return await Hive.openBox('${userId}_${categoryName}Workouts');
  }

  static Future<void> addWorkout(Box box, Map<String, dynamic> workout) async {
    await box.add(workout);
  }

  static Future<void> updateWorkout(
      Box box, int index, Map<String, dynamic> workout) async {
    await box.putAt(index, workout);
  }

  static Future<void> deleteWorkout(Box box, int index) async {
    await box.deleteAt(index);
  }
}
