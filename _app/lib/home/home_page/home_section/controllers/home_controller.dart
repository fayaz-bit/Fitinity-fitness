import 'package:_app/home/daily_goals_section/dashboard/controllers/daily_goals_controller.dart';
import 'package:_app/home/meal_plans/meal_level.dart';
import 'package:flutter/material.dart';
import '../../timer_section/screens/timer_screen.dart';
import '../../../profile_details/profile/screens/profile_screen.dart';
import '../../../feature_workouts/workout_flow_page/screens/workout_flow_screen.dart';
import '../../../calculator/screens/bmi_calculator_screen.dart';

class HomeController {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> homeSections = [
    {
      "title": "Feature Workouts",
      "images": [
        "assets/project1/homesection/home1.jpg",
        "assets/project1/homesection/home2.jpg"
      ]
    },
    {
      "title": "Meal Plans",
      "images": [
        "assets/project1/homesection/home3.jpg",
        "assets/project1/homesection/home4.jpg"
      ]
    },
    {
      "title": "Set Goals",
      "images": [
        "assets/project1/homesection/home5.jpg",
        "assets/project1/homesection/home6.jpg"
      ]
    },
    {
      "title": "Calculator",
      "images": [
        "assets/project1/homesection/home7.jpg",
        "assets/project1/homesection/home8.jpg"
      ]
    },
  ];

  void onNavTap(BuildContext context, int index, Function onUpdate) async {
    if (index == 1) return;

    selectedIndex = index;
    onUpdate();

    if (index == 0) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TimerScreen()),
      );
    } else if (index == 2) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }

    selectedIndex = 1;
    onUpdate();
  }

  void openSection(BuildContext context, String title) {
    switch (title) {
      case "Feature Workouts":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WorkoutFlowPage()),
        );
        break;

      case "Meal Plans":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MealLevelsScreen()),
        );
        break;

      case "Set Goals":
        // 🔥 THIS IS THE IMPORTANT FIX
        final controller = DailyGoalsController();
        controller.checkPlanAndNavigate(context);
        break;

      case "Calculator":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BMICalculatorScreen()),
        );
        break;
    }
  }
}
