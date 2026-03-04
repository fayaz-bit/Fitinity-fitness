import 'package:_app/database/dailkygoals_database/daily_goal_database.dart';
import 'package:_app/database/dailkygoals_database/daily_goal_plan.dart';
import 'package:_app/home/calculator/controllers/bmi_controller.dart';
import 'package:flutter/material.dart';
import '../controller/monthly_calendar_controller.dart';
import '../widget/month_calendar_card.dart';
import '../widget/workout_list_card.dart';
import 'package:_app/home/home_page/home_section/screens/home_screen.dart';

class MonthlyCalendarScreen extends StatefulWidget {
  final BmiCategory category;

  const MonthlyCalendarScreen({
    super.key,
    required this.category,
  });

  @override
  State<MonthlyCalendarScreen> createState() => _MonthlyCalendarScreenState();
}

class _MonthlyCalendarScreenState extends State<MonthlyCalendarScreen> {
  late MonthlyCalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = MonthlyCalendarController();
    controller.init().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.isReady) {
      return const Scaffold(
        backgroundColor: Color(0xFF0E0F13),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF9A4DFF),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0E0F13),
      appBar: AppBar(
        backgroundColor: const Color(0xFF15161C),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Workout Flow",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              final shouldQuit = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: const Color(0xFF1C1C1E),
                  title: const Text(
                    "Quit Plan?",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    "Are you sure you want to quit this 30-day plan?\nAll progress will be lost.",
                    style: TextStyle(color: Colors.white70),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Quit"),
                    ),
                  ],
                ),
              );

              if (shouldQuit == true) {
                final planDb = PlanStatusDatabase();
                await planDb.init();
                await planDb.deactivatePlan();

                final goalDb = DailyGoalDatabase();
                await goalDb.init();
                await goalDb.clearAll();

                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                }
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Month Plan Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7B2FF7),
                    Color(0xFF9A4DFF),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Month plan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Calendar Container
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF15161C),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// Calendar Grid
                  MonthCalendarCard(
                    controller: controller,
                    refresh: () => setState(() {}),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Image Banner Card
            Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image:
                      AssetImage("assets/project1/fitnesslevel/dailygoals.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black.withOpacity(0.6),
                ),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  "Welcome to Daily\nGoals",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// 🔥 FIXED HERE
            WorkoutListCard(
              day: controller.currentActiveDay,
              controller: controller,
              refresh: () => setState(() {}),
              category: widget.category,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
