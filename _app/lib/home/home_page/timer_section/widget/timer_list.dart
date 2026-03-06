import 'package:flutter/material.dart';
import '../controllers/timer_controller.dart';

class TimerList extends StatelessWidget {
  final TimerController controller;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onFinish;
  final VoidCallback onReset;
  final VoidCallback onUpdate;

  const TimerList({
    super.key,
    required this.controller,
    required this.onStart,
    required this.onPause,
    required this.onFinish,
    required this.onReset,
    required this.onUpdate,
  });

  Color get darkGrey => const Color(0xFF1C1C1E);
  Color get disabledGrey => const Color(0xFF2A2A2A);

  LinearGradient get violetGradient => const LinearGradient(
        colors: [
          Color(0xFF7B2FF7),
          Color(0xFF9A4DFF),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        const Text(
          "Set your workout time",
          style: TextStyle(color: Colors.white60, fontSize: 16),
        ),

        const SizedBox(height: 25),

        /// TIMER OPTIONS
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: WrapAlignment.center,
          children: [
            ...controller.timerOptions.map((min) {
              final isSelected = controller.selectedMinutes == min;

              return GestureDetector(
                onTap: controller.isRunning
                    ? null
                    : () => controller.changeMinutes(min, onUpdate),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isSelected ? violetGradient : null,
                    color: isSelected ? null : darkGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "${min}min",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),

            /// CUSTOM TIMER BUTTON
            GestureDetector(
              onTap: controller.isRunning
                  ? null
                  : () => _showCustomTimerDialog(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: darkGrey,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  "Custom",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),

        /// TIMER CIRCLE
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: violetGradient,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        controller.formatTime(),
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// RESET BUTTON
              GestureDetector(
                onTap: onReset,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: darkGrey,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white70,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// BUTTONS
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              /// START BUTTON
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: controller.isRunning ? null : violetGradient,
                  color: controller.isRunning ? disabledGrey : null,
                ),
                child: ElevatedButton(
                  onPressed: controller.isRunning ? null : onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    controller.isRunning ? "RUNNING..." : "START",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: _bottomButton(
                      "FINISH",
                      onFinish,
                      isActive: controller.isRunning,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _bottomButton(
                      controller.isRunning ? "REST" : "PAUSE",
                      onPause,
                      isActive: controller.isRunning,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bottomButton(
    String text,
    VoidCallback onTap, {
    required bool isActive,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: isActive ? violetGradient : null,
        color: isActive ? null : darkGrey,
      ),
      child: ElevatedButton(
        onPressed: isActive ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// CUSTOM TIMER DIALOG
  void _showCustomTimerDialog(BuildContext context) {
    final TextEditingController customController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1E),
          title: const Text(
            "Custom Timer",
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: customController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Enter minutes",
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final minutes = int.tryParse(customController.text.trim());

                if (minutes != null && minutes > 0) {
                  controller.setCustomMinutes(minutes, onUpdate);
                }

                Navigator.pop(context);
              },
              child: const Text("Set"),
            ),
          ],
        );
      },
    );
  }
}
