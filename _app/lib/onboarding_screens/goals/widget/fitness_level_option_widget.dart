import 'package:flutter/material.dart';

class FitnessLevelOption extends StatelessWidget {
  final String level;
  final bool isSelected;
  final VoidCallback onTap;

  const FitnessLevelOption({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 28),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          /// 🔥 SAME GRADIENT AS CONTINUE BUTTON
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
              level,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 10),
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 18,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
