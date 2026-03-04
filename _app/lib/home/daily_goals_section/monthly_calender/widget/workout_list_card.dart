import 'package:_app/home/calculator/controllers/bmi_controller.dart';
import 'package:_app/home/daily_goals_section/daily_workout_goals/screens/daily_workout_goals_screen.dart';
import 'package:flutter/material.dart';
import '../controller/monthly_calendar_controller.dart';

class WorkoutListCard extends StatelessWidget {
  final DateTime day;
  final MonthlyCalendarController controller;
  final VoidCallback refresh;
  final BmiCategory category;

  const WorkoutListCard({
    super.key,
    required this.day,
    required this.controller,
    required this.refresh,
    required this.category,
  });

  String _getMotivation(int index) {
    if (index == 0) {
      return "The journey begins today. Let’s build momentum 💪";
    } else if (index < 10) {
      return "Consistency creates champions 🔥";
    } else if (index < 20) {
      return "You’re building real discipline now 🚀";
    } else {
      return "Elite mindset activated. Keep pushing 👑";
    }
  }

  @override
  Widget build(BuildContext context) {
    final dayIndex = controller.days.indexWhere(
      (d) => controller.isSameDay(d, day),
    );

    final motivation = _getMotivation(dayIndex);

    return GestureDetector(
      onTap: () async {
        final completed = await Navigator.push<bool>(
          context,
          MaterialPageRoute(
            builder: (_) => DailyWorkoutGoalsScreen(
              day: day,
              category: category,
            ),
          ),
        );

        if (completed == true) {
          await controller.completeDay(day);
          refresh();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF15161C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const Text(
              "Workouts for today",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 14),

            /// Plan Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1F26),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  /// Icon Box
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9A4DFF).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.fitness_center,
                      color: Color(0xFF9A4DFF),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// Text Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's plan",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Day ${dayIndex + 1} • 45 min",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Active Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9A4DFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "active",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Motivation text
            Text(
              motivation,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
