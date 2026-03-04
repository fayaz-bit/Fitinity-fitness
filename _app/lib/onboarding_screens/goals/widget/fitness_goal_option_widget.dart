import 'package:flutter/material.dart';

class FitnessGoalOption extends StatelessWidget {
  final String goal;
  final bool isSelected;
  final VoidCallback onTap;

  const FitnessGoalOption({
    super.key,
    required this.goal,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          /// SAME GRADIENT AS CONTINUE
          gradient: isSelected
              ? const LinearGradient(
                  colors: [
                    Color(0xFF7B2FF7),
                    Color(0xFF9A4DFF),
                  ],
                )
              : null,

          color: isSelected ? null : const Color(0xFF1C1F26),

          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white10,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              goal,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.white70,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 10),
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 18,
              )
            ]
          ],
        ),
      ),
    );
  }
}
