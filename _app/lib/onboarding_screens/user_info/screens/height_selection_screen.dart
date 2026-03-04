import 'package:flutter/material.dart';
import 'wieght_selection_screen.dart';

class HeightSelection extends StatefulWidget {
  final String gender;
  const HeightSelection({super.key, required this.gender});

  @override
  State<HeightSelection> createState() => _HeightSelectionState();
}

class _HeightSelectionState extends State<HeightSelection> {
  int selectedHeight = 155;

  Future<void> _saveHeight() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeightSelection(
          gender: widget.gender,
          height: selectedHeight.toString(),
        ),
      ),
    );
  }

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
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Select your ",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: "height",
                        style: TextStyle(color: Color(0xFF9A4DFF)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "This helps us create better workout plans.",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                /// Height Picker Container
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F26),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Height (cm)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 55,
                              physics: const FixedExtentScrollPhysics(),
                              onSelectedItemChanged: (index) {
                                setState(() => selectedHeight = 100 + index);
                              },
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 151,
                                builder: (context, index) {
                                  int height = 100 + index;
                                  bool isSelected = height == selectedHeight;

                                  return Center(
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xFF7B2FF7),
                                                  Color(0xFF9A4DFF),
                                                ],
                                              )
                                            : null,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "$height cm",
                                        style: TextStyle(
                                          fontSize: isSelected ? 22 : 18,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white54,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF7B2FF7),
                                Color(0xFF9A4DFF),
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: _saveHeight,
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
