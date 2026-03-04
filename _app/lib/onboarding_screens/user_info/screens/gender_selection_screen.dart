import 'package:_app/onboarding_screens/user_info/screens/height_selection_screen.dart';
import 'package:_app/onboarding_screens/user_info/widget/gender_selection_widgets.dart';
import 'package:flutter/material.dart';
import '../controllers/gender_selection_controller.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  final GenderSelectionController controller = GenderSelectionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  const Color(0xFF111111),
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
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "What's your ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "gender",
                        style: TextStyle(color: Color(0xFF9A4DFF)),
                      ),
                      TextSpan(
                        text: "?",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "This helps us personalize your fitness journey.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                /// Gender Options
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        genderBox(
                          gender: "male",
                          icon: Icons.male,
                          selectedGender: controller.selectedGender,
                          onTap: () {
                            setState(() {
                              controller.selectGender("male");
                            });
                          },
                        ),
                        const SizedBox(height: 25),
                        genderBox(
                          gender: "female",
                          icon: Icons.female,
                          selectedGender: controller.selectedGender,
                          onTap: () {
                            setState(() {
                              controller.selectGender("female");
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                /// Bottom Buttons
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
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
                            gradient: controller.isSelected
                                ? const LinearGradient(
                                    colors: [
                                      Color(0xFF7B2FF7),
                                      Color(0xFF9A4DFF),
                                    ],
                                  )
                                : null,
                            color: controller.isSelected
                                ? null
                                : const Color(0xFF2A2A2A),
                          ),
                          child: ElevatedButton(
                            onPressed: controller.isSelected
                                ? () async {
                                    await controller.saveGenderToHive();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HeightSelection(
                                          gender: controller.selectedGender,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
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
