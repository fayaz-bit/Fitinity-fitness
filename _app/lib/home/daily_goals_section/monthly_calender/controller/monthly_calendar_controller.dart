import 'package:_app/database/dailkygoals_database/daily_goal_database.dart';

class MonthlyCalendarController {
  final DateTime startDate;
  final DailyGoalDatabase goalDb = DailyGoalDatabase();

  bool isReady = false;

  MonthlyCalendarController({DateTime? start})
      : startDate = start ?? DateTime.now();

  Future<void> init() async {
    await goalDb.init();
    isReady = true;
  }

  ///  Fixed 30-day plan
  List<DateTime> get days {
    return List.generate(
      30,
      (i) => startDate.add(Duration(days: i)),
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Convert Date → 20260225 format
  int dayNumber(DateTime day) {
    return int.parse(
      "${day.year}"
      "${day.month.toString().padLeft(2, '0')}"
      "${day.day.toString().padLeft(2, '0')}",
    );
  }

  /// Check if a day is completed
  bool isCompleted(DateTime day) {
    if (!isReady) return false;
    return goalDb.isDayCompleted(dayNumber(day));
  }

  ///  Get first uncompleted day (AUTO FIXED LOGIC)
  DateTime get currentActiveDay {
    if (!isReady) return startDate;

    for (final day in days) {
      if (!goalDb.isDayCompleted(dayNumber(day))) {
        return day; // First uncompleted day
      }
    }

    // If all 30 days completed
    return days.last;
  }

  /// Mark a day completed
  Future<void> completeDay(DateTime day) async {
    if (!isReady) return;

    await goalDb.markDayCompleted(dayNumber(day));
  }

  ///  Quit entire plan
  Future<void> quitPlan() async {
    if (!isReady) return;

    await goalDb.clearAll();
  }
}
