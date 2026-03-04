import 'package:_app/database/dailkygoals_database/daily_goal_database.dart';
import 'package:_app/home/calculator/controllers/bmi_controller.dart';

class DailyWorkoutGoalsController {
  final DailyGoalDatabase db;
  final int dayNumber;
  final BmiCategory category;

  DailyWorkoutGoalsController({
    required this.db,
    required this.dayNumber,
    required this.category,
  });

  bool nutrition = false;
  bool hydration = false;
  bool workout = false;
  bool cardio = false;
  bool recovery = false;

  Future<void> load() async {
    final data = db.loadDailyWorkoutGoals(dayNumber);

    nutrition = data["nutrition"] ?? false;
    hydration = data["hydration"] ?? false;
    workout = data["workout"] ?? false;
    cardio = data["cardio"] ?? false;
    recovery = data["recovery"] ?? false;
  }

  int get completed =>
      [nutrition, hydration, workout, cardio, recovery].where((e) => e).length;

  double get progress => completed / 5;

  Future<void> save() async {
    await db.saveDailyWorkoutGoals(
      dayNumber,
      nutrition: nutrition,
      hydration: hydration,
      workout: workout,
      cardio: cardio,
      recovery: recovery,
    );
  }

  // 🔥 Dynamic Targets

  String get nutritionTarget {
    switch (category) {
      case BmiCategory.underweight:
        return "Target: 2200 kcal & 120g Protein";
      case BmiCategory.normal:
        return "Target: 2500 kcal & 150g Protein";
      case BmiCategory.overweight:
        return "Target: 2000 kcal & 120g Protein";
    }
  }

  String get hydrationTarget {
    switch (category) {
      case BmiCategory.normal:
        return "Goal: 3.0 Liters of Water";
      default:
        return "Goal: 2.5 Liters of Water";
    }
  }

  String get workoutPlan {
    switch (category) {
      case BmiCategory.underweight:
        return "Strength Training • 45 min";
      case BmiCategory.normal:
        return "Mixed Training • 45 min";
      case BmiCategory.overweight:
        return "Fat Burn + Cardio • 45 min";
    }
  }

  String get cardioPlan {
    switch (category) {
      case BmiCategory.overweight:
        return "20 mins • 6 km walk";
      case BmiCategory.normal:
        return "15 mins • 5 km jog";
      case BmiCategory.underweight:
        return "10 mins light cardio";
    }
  }
}
