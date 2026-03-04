import 'package:hive/hive.dart';

class FitnessPlanService {
  static const String boxName = "fitnessPlans";
  static Box? _box;

  static Future<void> init() async {
    if (_box != null) return;

    _box = await Hive.openBox(boxName);

    if (_box!.isEmpty) {
      await _loadDefaults();
    }
  }

  static Box get box {
    if (_box == null) {
      throw Exception("FitnessPlanService not initialized.");
    }
    return _box!;
  }

  static Future<void> _loadDefaults() async {
    await _box!.put("loss", {
      "workouts": [
        {"title": "Brisk Walking / Jogging", "duration": "30–40 mins"},
        {"title": "Jump Rope", "duration": "15 mins"},
        {"title": "Cycling / Treadmill", "duration": "20 mins"},
        {"title": "HIIT Circuit", "duration": "12 rounds"},
        {"title": "Fat Burn Workout", "duration": "25 mins"},
      ],
      "foods": [
        {"title": "Oats with Banana"},
        {"title": "Boiled Eggs & Fruits"},
        {"title": "Grilled Chicken / Paneer"},
        {"title": "Brown Rice & Veggies"},
        {"title": "Green Salad"},
        {"title": "Low Fat Curd"},
      ],
      "tips": [
        "Walk minimum 8,000 steps",
        "Avoid sugar and junk food",
        "Drink 3–4 liters of water",
        "Sleep at least 7 hours",
        "Weigh weekly not daily",
        "Stay consistent",
      ],
    });

    await _box!.put("gain", {
      "workouts": [
        {"title": "Push-ups", "sets": "4 × 12"},
        {"title": "Squats", "sets": "5 × 10"},
        {"title": "Pull-ups", "sets": "3 × 6"},
        {"title": "Bench Press", "sets": "4 × 8"},
        {"title": "Shoulder Press", "sets": "4 × 10"},
      ],
      "foods": [
        {"title": "Eggs & Rice"},
        {"title": "Peanut Butter Toast"},
        {"title": "Paneer / Chicken / Fish"},
        {"title": "Milk & Dates"},
        {"title": "Banana Shake"},
        {"title": "Dry Fruits"},
      ],
      "tips": [
        "Eat every 3 hours",
        "Increase calories slowly",
        "Lift heavy with good form",
        "Sleep 7–9 hours",
        "Avoid empty calories",
        "Be patient with gains",
      ],
    });

    await _box!.put("maintain", {
      "workouts": [
        {"title": "Jogging / Walking", "duration": "20 mins"},
        {"title": "Yoga & Stretching", "duration": "25 mins"},
        {"title": "Bodyweight workout", "duration": "15 mins"},
        {"title": "Cycling / Sports", "duration": "Weekly"},
      ],
      "foods": [
        {"title": "Balanced home meals"},
        {"title": "Seasonal fruits"},
        {"title": "Eggs / Paneer"},
        {"title": "Vegetables & greens"},
        {"title": "Healthy fats"},
      ],
      "tips": [
        "Stay active daily",
        "Drink enough water",
        "Maintain meal timings",
        "Eat enough protein",
        "Avoid late night eating",
        "Live balanced",
      ],
    });
  }

  static Map<String, dynamic> getPlan(String category) {
    final data = box.get(category);

    if (data == null) {
      return {
        "workouts": <Map<String, dynamic>>[],
        "foods": <Map<String, dynamic>>[],
        "tips": <String>[],
      };
    }

    final raw = Map<String, dynamic>.from(
      (data as Map).map(
        (key, value) => MapEntry(key.toString(), value),
      ),
    );

    return {
      "workouts": (raw["workouts"] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      "foods": (raw["foods"] as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList(),
      "tips": List<String>.from(raw["tips"]),
    };
  }
}
