import 'package:flutter/material.dart';
import '../controllers/daily_workout_goals_controllers.dart';

class DailyWorkoutGoalsWidget extends StatelessWidget {
  final DailyWorkoutGoalsController controller;
  final VoidCallback refresh;

  const DailyWorkoutGoalsWidget({
    super.key,
    required this.controller,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (controller.progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Daily Goals",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        // 🔥 Progress
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF15161C),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircularProgressIndicator(
                value: controller.progress,
                strokeWidth: 8,
                backgroundColor: Colors.white12,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 12),
              Text(
                "$percent% completed",
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        _goalTile(
          icon: Icons.restaurant,
          title: "Nutrition",
          subtitle: controller.nutritionTarget,
          value: controller.nutrition,
          onChanged: (v) async {
            controller.nutrition = v;
            await controller.save();
            refresh();
          },
        ),

        _goalTile(
          icon: Icons.water_drop,
          title: "Hydration",
          subtitle: controller.hydrationTarget,
          value: controller.hydration,
          onChanged: (v) async {
            controller.hydration = v;
            await controller.save();
            refresh();
          },
        ),

        _goalTile(
          icon: Icons.fitness_center,
          title: "Workout",
          subtitle: controller.workoutPlan,
          value: controller.workout,
          onChanged: (v) async {
            controller.workout = v;
            await controller.save();
            refresh();
          },
        ),

        _goalTile(
          icon: Icons.favorite,
          title: "Cardio",
          subtitle: controller.cardioPlan,
          value: controller.cardio,
          onChanged: (v) async {
            controller.cardio = v;
            await controller.save();
            refresh();
          },
        ),

        _goalTile(
          icon: Icons.self_improvement,
          title: "Mind & Recovery",
          subtitle: "Meditate 15 mins & Sleep 8 hrs",
          value: controller.recovery,
          onChanged: (v) async {
            controller.recovery = v;
            await controller.save();
            refresh();
          },
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.completed == 5
                ? () => Navigator.pop(context, true)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            child: const Text("Complete Daily Goals"),
          ),
        ),
      ],
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF15161C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
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
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Checkbox(
            value: value,
            activeColor: Colors.deepPurple,
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}
