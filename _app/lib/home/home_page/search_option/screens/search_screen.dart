import 'package:flutter/material.dart';

// 🔹 Feature Workouts
import 'package:_app/home/feature_workouts/workout_flow_page/screens/workout_flow_screen.dart';
import 'package:_app/home/feature_workouts/arms_workout/screens/arms_workout_screen.dart';
import 'package:_app/home/feature_workouts/back_workout/screens/back_workout_screen.dart';
import 'package:_app/home/feature_workouts/chest_workout/screens/chest_workout.dart';
import 'package:_app/home/feature_workouts/leg_workout/screens/leg_workout_screen.dart';
import 'package:_app/home/feature_workouts/shoulder_workout/screens/shoulder_workout_screen.dart';
import 'package:_app/home/feature_workouts/warmup/warm_up.dart';

// 🔹 Meal Plans
import 'package:_app/home/meal_plans/meal_level.dart';
import 'package:_app/home/meal_plans/gain_weight/wiegthgain.dart';
import 'package:_app/home/meal_plans/loss_weight/wieghtloss.dart';
import 'package:_app/home/meal_plans/maintain_weight/maintain.dart';

// 🔹 Daily Goals
import 'package:_app/home/daily_goals_section/dashboard/screens/daily_goal_dashboard.dart';

// 🔹 Calculator
import 'package:_app/home/calculator/screens/bmi_calculator_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> allItems = [
    // 🏋️ FEATURE WORKOUTS
    {
      "title": "Feature Workouts",
      "subtitle": "Main Section",
      "page": const WorkoutFlowPage()
    },
    {
      "title": "Arms Workout",
      "subtitle": "Feature Workouts",
      "page": const ArmsWorkoutScreen()
    },
    {
      "title": "Back Workout",
      "subtitle": "Feature Workouts",
      "page": const BackWorkoutScreen()
    },
    {
      "title": "Chest Workout",
      "subtitle": "Feature Workouts",
      "page": const ChestWorkoutScreen()
    },
    {
      "title": "Leg Workout",
      "subtitle": "Feature Workouts",
      "page": const LegWorkoutScreen()
    },
    {
      "title": "Shoulder Workout",
      "subtitle": "Feature Workouts",
      "page": const ShoulderWorkoutScreen()
    },
    {
      "title": "Warm-up Routine",
      "subtitle": "Feature Workouts",
      "page": const WarmUpGuideScreen()
    },

    // 🍽️ MEAL PLANS
    {
      "title": "Meal Levels",
      "subtitle": "Main Section",
      "page": const MealLevelsScreen()
    },
    {
      "title": "Weight Gain Plan",
      "subtitle": "Meal Plans",
      "page": const WeightGainPage()
    },
    {
      "title": "Weight Loss Plan",
      "subtitle": "Meal Plans",
      "page": const WeightLossPage()
    },
    {
      "title": "Maintain Plan",
      "subtitle": "Meal Plans",
      "page": const MaintainWeightPage()
    },

    // 🎯 DAILY GOALS
    {
      "title": "Daily Goals",
      "subtitle": "Main Section",
      "page": DailyGoalsScreen()
    },

    // ⚖️ CALCULATOR
    {
      "title": "BMI Calculator",
      "subtitle": "Calculator",
      "page": const BMICalculatorScreen()
    },
  ];

  List<Map<String, dynamic>> filteredItems = [];

  void _search(String query) {
    setState(() {
      filteredItems = allItems
          .where((item) =>
              item["title"]
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item["subtitle"]
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredItems = allItems; // show all items first
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _search,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search workouts, meals, goals, calculators...",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
        ),
      ),
      body: filteredItems.isEmpty
          ? const Center(
              child: Text(
                "No results found",
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];

                return ListTile(
                  title: Text(
                    item["title"],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    item["subtitle"],
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white54, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item["page"]),
                    );
                  },
                );
              },
            ),
    );
  }
}
