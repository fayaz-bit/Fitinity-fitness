import 'package:_app/onboarding_screens/goals/controllers/fitness_goal_controller.dart';
import 'package:_app/onboarding_screens/goals/widget/fitness_goal_option_widget.dart';
import 'package:flutter/material.dart';
import 'package:_app/authentication/screens/sign_up_screen.dart';

class FitnessGoalScreen extends StatefulWidget {
  final String gender;
  final String height;
  final String weight;
  final String age;

  const FitnessGoalScreen({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
  });

  @override
  State<FitnessGoalScreen> createState() => _FitnessGoalScreenState();
}

class _FitnessGoalScreenState extends State<FitnessGoalScreen> {
  final FitnessGoalController controller = FitnessGoalController();

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

          /// Purple Glow
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF9A4DFF).withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
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
                        text: "Select your\n",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "fitness goal",
                        style: TextStyle(color: Color(0xFF9A4DFF)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  "Choose your primary focus to personalize your plan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                /// Options
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        FitnessGoalOption(
                          goal: "Weight Loss",
                          isSelected: controller.isSelected("Weight Loss"),
                          onTap: () => setState(
                              () => controller.selectGoal("Weight Loss")),
                        ),
                        const SizedBox(height: 18),
                        FitnessGoalOption(
                          goal: "Muscle Gain",
                          isSelected: controller.isSelected("Muscle Gain"),
                          onTap: () => setState(
                              () => controller.selectGoal("Muscle Gain")),
                        ),
                        const SizedBox(height: 18),
                        FitnessGoalOption(
                          goal: "Improve Endurance",
                          isSelected:
                              controller.isSelected("Improve Endurance"),
                          onTap: () => setState(
                              () => controller.selectGoal("Improve Endurance")),
                        ),
                        const SizedBox(height: 18),
                        FitnessGoalOption(
                          goal: "General Fitness",
                          isSelected: controller.isSelected("General Fitness"),
                          onTap: () => setState(
                              () => controller.selectGoal("General Fitness")),
                        ),
                        const SizedBox(height: 18),
                        FitnessGoalOption(
                          goal: "Build Strength",
                          isSelected: controller.isSelected("Build Strength"),
                          onTap: () => setState(
                              () => controller.selectGoal("Build Strength")),
                        ),
                        const SizedBox(height: 18),
                        FitnessGoalOption(
                          goal: "Increase Flexibility",
                          isSelected:
                              controller.isSelected("Increase Flexibility"),
                          onTap: () => setState(() =>
                              controller.selectGoal("Increase Flexibility")),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

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
                                  builder: (context) => SignUpScreen(
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
