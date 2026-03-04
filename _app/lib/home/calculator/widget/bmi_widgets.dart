import 'package:flutter/material.dart';

const purple = Color(0xFF9B4DFF);

Widget buildBMIInput({
  required IconData icon,
  required String label,
  required TextEditingController controller,
  required String unit,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF8416BC), size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white60, fontSize: 15),
              border: InputBorder.none,
            ),
          ),
        ),
        Text(unit, style: const TextStyle(color: Colors.white38)),
      ],
    ),
  );
}

/// 3 OPTION TOGGLE BAR
Widget buildToggleBar3({
  required int selected, // 0 loss, 1 maintain, 2 gain
  required Function(int) onSelect,
}) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Row(
      children: [
        buildToggleItem("Weight Loss", 0, selected, onSelect),
        buildToggleItem("Maintain", 1, selected, onSelect),
        buildToggleItem("Weight Gain", 2, selected, onSelect),
      ],
    ),
  );
}

Widget buildToggleItem(
    String text, int index, int selected, Function(int) onSelect) {
  return Expanded(
    child: GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color:
              selected == index ? const Color(0xFF8416BC) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
}

/// BMI RESULT CARD (FULL WIDTH NOW)
Widget buildBMIResultCard(double bmi) {
  String status;
  String description;

  if (bmi < 18.5) {
    status = "Underweight";
    description =
        "Your BMI indicates that you are underweight. Focus on eating nutrient-rich foods and strength-building exercises to gain healthy weight. Ensure proper rest and increase your calorie intake gradually.";
  } else if (bmi < 25) {
    status = "Normal Weight";
    description =
        "Your BMI indicates a normal weight. Maintaining a balanced diet and regular physical activity is highly recommended to support long-term health and well-being. Stay consistent with healthy habits.";
  } else if (bmi < 30) {
    status = "Overweight";
    description =
        "Your BMI indicates overweight. You can improve your health through regular workouts, calorie control, and a cleaner diet. Avoid junk meals and stay active daily for better results.";
  } else {
    status = "Obese";
    description =
        "Your BMI indicates obesity. It is advised to adopt a structured fitness routine and healthy eating plan. Professional medical guidance may also be helpful in your weight journey.";
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xFF8416BC),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your BMI",
          style: TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 8),

        // BMI VALUE
        Text(
          bmi.toStringAsFixed(2),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        // STATUS CHIP
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // DESCRIPTION TEXT
        Text(
          description,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}
