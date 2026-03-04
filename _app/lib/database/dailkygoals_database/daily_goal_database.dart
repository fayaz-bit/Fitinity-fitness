import 'package:hive_flutter/hive_flutter.dart';

class DailyGoalDatabase {
  Box? _goalsBox;
  String? currentUserId;
  bool isInitialized = false;

  Box get box => _goalsBox!;

  Future<void> init() async {
    await Hive.initFlutter();

    var sessionBox = await Hive.openBox('session');
    currentUserId = sessionBox.get('currentUserId');

    _goalsBox = await Hive.openBox('${currentUserId}_dailyGoals');
    isInitialized = true;
  }

  // =====================================================
  // SAVE OR UPDATE DAILY WORKOUT GOALS (NEW STRUCTURE)
  // =====================================================
  Future<void> saveDailyWorkoutGoals(
    int dayNumber, {
    required bool nutrition,
    required bool hydration,
    required bool workout,
    required bool cardio,
    required bool recovery,
  }) async {
    if (!isInitialized) return;

    final existing = Map<String, dynamic>.from(
      _goalsBox!.get(dayNumber) ?? {},
    );

    final updatedData = {
      ...existing,

      // OLD DATA (keep safe)
      "calories": existing["calories"] ?? [],
      "water": existing["water"] ?? [],
      "workout_list": existing["workout_list"] ?? [],
      "jogging": existing["jogging"] ?? [],
      "goals": existing["goals"] ?? [],

      // NEW BOOLEAN DATA
      "nutrition_done": nutrition,
      "hydration_done": hydration,
      "workout_done": workout,
      "cardio_done": cardio,
      "recovery_done": recovery,

      "day": dayNumber,
      "date": DateTime.now().toIso8601String(),
    };

    await _goalsBox!.put(dayNumber, updatedData);
  }

  // =====================================================
  // LOAD DAILY WORKOUT GOALS
  // =====================================================
  Map<String, bool> loadDailyWorkoutGoals(int dayNumber) {
    if (!isInitialized) return {};

    final goal = _goalsBox!.get(dayNumber);

    if (goal == null) {
      return {
        "nutrition": false,
        "hydration": false,
        "workout": false,
        "cardio": false,
        "recovery": false,
      };
    }

    return {
      "nutrition": goal["nutrition_done"] ?? false,
      "hydration": goal["hydration_done"] ?? false,
      "workout": goal["workout_done"] ?? false,
      "cardio": goal["cardio_done"] ?? false,
      "recovery": goal["recovery_done"] ?? false,
    };
  }

  // =====================================================
  // CHECK IF FULLY COMPLETED
  // =====================================================
  bool isDayCompleted(int dayNumber) {
    final data = loadDailyWorkoutGoals(dayNumber);

    return data.values.every((value) => value == true);
  }

  // =====================================================
  // OLD FUNCTIONS (UNCHANGED)
  // =====================================================

  Future<void> deleteGoal(int dayNumber) async {
    if (!isInitialized) return;
    await _goalsBox!.delete(dayNumber);
  }

  List<Map> getAllGoals() {
    if (!isInitialized) return [];
    return _goalsBox!.values.cast<Map>().toList();
  }

  Map<String, dynamic>? getGoalForDay(int dayNumber) {
    if (!isInitialized) return null;

    final goal = _goalsBox!.get(dayNumber);
    return goal != null ? Map<String, dynamic>.from(goal) : null;
  }

  Future<void> clearAll() async {
    await _goalsBox?.clear();
  }

  markDayCompleted(int dayNumber) {}
}
