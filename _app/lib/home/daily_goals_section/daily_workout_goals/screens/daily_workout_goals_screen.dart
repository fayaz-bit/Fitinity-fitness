import 'package:_app/database/dailkygoals_database/daily_goal_database.dart';
import 'package:_app/home/calculator/controllers/bmi_controller.dart';
import 'package:_app/home/daily_goals_section/daily_workout_goals/controllers/daily_workout_goals_controllers.dart';
import 'package:flutter/material.dart';

class DailyWorkoutGoalsScreen extends StatefulWidget {
  final DateTime day;
  final BmiCategory category;

  const DailyWorkoutGoalsScreen({
    super.key,
    required this.day,
    required this.category,
  });

  @override
  State<DailyWorkoutGoalsScreen> createState() =>
      _DailyWorkoutGoalsScreenState();
}

class _DailyWorkoutGoalsScreenState extends State<DailyWorkoutGoalsScreen> {
  final DailyGoalDatabase _db = DailyGoalDatabase();

  late DailyWorkoutGoalsController controller;
  bool isReady = false;

  int get dayNumber {
    final d = widget.day;
    return int.parse(
      "${d.year}"
      "${d.month.toString().padLeft(2, '0')}"
      "${d.day.toString().padLeft(2, '0')}",
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await _db.init();

    controller = DailyWorkoutGoalsController(
      db: _db,
      dayNumber: dayNumber,
      category: widget.category,
    );

    await controller.load();

    setState(() {
      isReady = true;
    });
  }

  Future<void> _toggle(Function update) async {
    update();
    await controller.save();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF9A4DFF),
          ),
        ),
      );
    }

    final percent = (controller.progress * 100).toInt();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Your Daily Goals",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 PROGRESS CARD
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF15161C),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  /// Circular Progress with Text Inside
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 110,
                        width: 110,
                        child: CircularProgressIndicator(
                          value: controller.progress,
                          strokeWidth: 10,
                          backgroundColor: Colors.white12,
                          color: const Color(0xFF9A4DFF),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "$percent%",
                            style: const TextStyle(
                              color: Color(0xFF9A4DFF),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.completed} of 5",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "You're doing great! Keep pushing towards your daily achievements.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _goalTile(
              icon: Icons.restaurant,
              title: "Nutrition",
              subtitle: controller.nutritionTarget,
              value: controller.nutrition,
              onChanged: (v) => _toggle(() {
                controller.nutrition = v;
              }),
            ),

            _goalTile(
              icon: Icons.water_drop,
              title: "Hydration",
              subtitle: controller.hydrationTarget,
              value: controller.hydration,
              onChanged: (v) => _toggle(() {
                controller.hydration = v;
              }),
            ),

            _goalTile(
              icon: Icons.fitness_center,
              title: "Workout",
              subtitle: controller.workoutPlan,
              value: controller.workout,
              onChanged: (v) => _toggle(() {
                controller.workout = v;
              }),
            ),

            _goalTile(
              icon: Icons.favorite,
              title: "Cardio",
              subtitle: controller.cardioPlan,
              value: controller.cardio,
              onChanged: (v) => _toggle(() {
                controller.cardio = v;
              }),
            ),

            _goalTile(
              icon: Icons.self_improvement,
              title: "Mind & Recovery",
              subtitle: "Meditate 15 mins & 8 hours of sleep",
              value: controller.recovery,
              onChanged: (v) => _toggle(() {
                controller.recovery = v;
              }),
            ),

            const SizedBox(height: 24),

            /// COMPLETE BUTTON
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: controller.completed == 5
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF7B2FF7),
                          Color(0xFF9A4DFF),
                        ],
                      )
                    : null,
                color:
                    controller.completed == 5 ? null : const Color(0xFF2A2A2A),
              ),
              child: ElevatedButton(
                onPressed: controller.completed == 5
                    ? () => Navigator.pop(context, true)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Complete Daily Goals",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _goalTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF15161C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          /// Left Icon
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF9A4DFF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF9A4DFF),
            ),
          ),

          const SizedBox(width: 14),

          /// Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          /// Checkbox
          Checkbox(
            value: value,
            activeColor: const Color(0xFF9A4DFF),
            side: const BorderSide(color: Colors.white54),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}
