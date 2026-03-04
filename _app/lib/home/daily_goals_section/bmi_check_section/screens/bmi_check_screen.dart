import 'package:flutter/material.dart';
import 'package:_app/database/dailkygoals_database/daily_goal_plan.dart';
import 'package:_app/home/daily_goals_section/monthly_calender/screens/monthly_calendar_screen.dart';
import 'package:_app/home/calculator/controllers/bmi_controller.dart';
import 'package:_app/home/calculator/screens/bmi_calculator_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final BmiController controller = BmiController();

  @override
  void dispose() {
    controller.disposeController();
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
    await planDb.activatePlan(controller.category!);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MonthlyCalendarScreen(
          category: controller.category!,
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
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Tell us about you",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                "Enter your Body Mass Index (BMI) to personalize your goals. You can find this value using an online calculator.",
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Enter your BMI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1F26),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: controller.bmiTextController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                    hintText: "e.g. 22.5",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  const Text(
                    "Not sure? Use ",
                    style: TextStyle(color: Colors.white54),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const BMICalculatorScreen(), // 🔥 change if name different
                        ),
                      );
                    },
                    child: const Text(
                      "BMI calculator",
                      style: TextStyle(
                        color: Color(0xFF9A4DFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              /// CHECK BUTTON
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7B2FF7),
                      Color(0xFF9A4DFF),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: handleCheck,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Check BMI",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// MOTIVATION CARD
              Container(
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/project1/onboarding/1stpage.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.6),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Consistency beats intensity. Every single time.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (controller.hasResult) ...[
                const Text(
                  "Recommendations based on your input:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                _recommendationCard(
                  title: "Suggested Calories",
                  value: "${controller.calories} kcal",
                ),

                const SizedBox(height: 16),

                _recommendationCard(
                  title: "Daily Water Target",
                  value: "${controller.water} Liters",
                ),

                const SizedBox(height: 16),

                _recommendationCard(
                  title: "Protein Intake",
                  value: "${controller.protein}g Protein",
                ),

                const SizedBox(height: 30),

                /// ACTIVATE PLAN BUTTON
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF7B2FF7),
                        Color(0xFF9A4DFF),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: activatePlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Use the 1 month plan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recommendationCard({
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F26),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF9A4DFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.info_outline,
            color: Color(0xFF9A4DFF),
          )
        ],
      ),
    );
  }
}
