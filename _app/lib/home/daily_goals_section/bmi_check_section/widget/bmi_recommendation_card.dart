import 'package:_app/database/dailkygoals_database/daily_goal_plan.dart';
import 'package:_app/home/daily_goals_section/monthly_calender/screens/monthly_calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:_app/home/calculator/controllers/bmi_controller.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final BmiController controller = BmiController();

  @override
  void dispose() {
    controller.disposeController(); // ✅ correct dispose method
    super.dispose();
  }

  void handleCheck() {
    setState(() {
      controller.calculateFromBmi();
    });
  }

  Future<void> activatePlan() async {
    if (controller.category == null) return;

    final planDb = PlanStatusDatabase();
    await planDb.init();

    // ✅ FIXED: Pass category into Hive
    await planDb.activatePlan(controller.category!);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MonthlyCalendarScreen(
          category: controller.category!, // ✅ always valid
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
        title: const Text("Tell us about you"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your Body Mass Index (BMI) to personalize your goals.",
              style: TextStyle(color: Colors.white70, height: 1.4),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter your BMI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: controller.bmiTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "e.g., 22.5",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: handleCheck,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
                child: const Text("Check BMI"),
              ),
            ),
            const Spacer(),
            if (controller.hasResult) ...[
              const Text(
                "Recommendations:",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text("Calories: ${controller.calories} kcal",
                  style: const TextStyle(color: Colors.white)),
              Text("Water: ${controller.water} L",
                  style: const TextStyle(color: Colors.white)),
              Text("Protein: ${controller.protein} g",
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: activatePlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Text("Use the 1 month plan"),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
