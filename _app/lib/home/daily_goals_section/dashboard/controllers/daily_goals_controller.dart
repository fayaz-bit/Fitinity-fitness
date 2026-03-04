import 'package:_app/database/dailkygoals_database/daily_goal_plan.dart';
import 'package:_app/home/daily_goals_section/bmi_check_section/screens/bmi_check_screen.dart';
import 'package:_app/home/daily_goals_section/dashboard/screens/daily_goal_dashboard.dart';
import 'package:_app/home/daily_goals_section/monthly_calender/screens/monthly_calendar_screen.dart';
import 'package:flutter/material.dart';

class DailyGoalsController {
  /// 🔥 First time setup
  Future<void> onSetMeUp(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BmiScreen(),
      ),
    );
  }

  /// 🔥 Called from Home → Daily Goals
  Future<void> checkPlanAndNavigate(BuildContext context) async {
    final planDb = PlanStatusDatabase();
    await planDb.init();

    if (planDb.isPlanActive && planDb.savedCategory != null) {
      final category = planDb.savedCategory!;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MonthlyCalendarScreen(
            category: category, // ✅ FIXED
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DailyGoalsScreen(),
        ),
      );
    }
  }

  void onSkip(BuildContext context) {
    Navigator.pop(context);
  }
}
