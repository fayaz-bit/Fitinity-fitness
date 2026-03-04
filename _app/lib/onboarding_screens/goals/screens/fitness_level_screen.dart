import 'package:_app/onboarding_screens/goals/controllers/fitness_level_controller.dart';
import 'package:_app/onboarding_screens/goals/screens/fitness_goal_screen.dart';
import 'package:_app/onboarding_screens/goals/widget/fitness_level_option_widget.dart';
import 'package:flutter/material.dart';

class FitnessLevelScreen extends StatefulWidget {
  final String gender;
  final String height;
  final String weight;
  final String age;

  const FitnessLevelScreen({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
  });

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  final FitnessLevelController controller = FitnessLevelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color(0xFF111111),
                  Colors.black,
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// Title
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Select your current\n",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "fitness level",
                        style: TextStyle(color: Color(0xFF9A4DFF)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "This helps us customize your training intensity.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                /// Options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      FitnessLevelOption(
                        level: "Beginner",
                        isSelected: controller.isSelected("Beginner"),
                        onTap: () =>
                            setState(() => controller.selectLevel("Beginner")),
                      ),
                      const SizedBox(height: 18),
                      FitnessLevelOption(
                        level: "Intermediate",
                        isSelected: controller.isSelected("Intermediate"),
                        onTap: () => setState(
                            () => controller.selectLevel("Intermediate")),
                      ),
                      const SizedBox(height: 18),
                      FitnessLevelOption(
                        level: "Advanced",
                        isSelected: controller.isSelected("Advanced"),
                        onTap: () =>
                            setState(() => controller.selectLevel("Advanced")),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// Bottom Buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: controller.canContinue
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF7B2FF7),
                                      Color(0xFF9A4DFF),
                                    ],
                                  )
                                : null,
                            color: controller.canContinue
                                ? null
                                : const Color(0xFF2A2A2A),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () {
                              if (!controller.canContinue) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FitnessGoalScreen(
                                    gender: widget.gender,
                                    height: widget.height,
                                    weight: widget.weight,
                                    age: widget.age,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
