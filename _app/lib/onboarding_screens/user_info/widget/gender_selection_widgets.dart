import 'package:flutter/material.dart';

Widget genderBox({
  required String gender,
  required String selectedGender,
  required VoidCallback onTap,
  required IconData icon,
}) {
  bool isSelected = selectedGender == gender;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2D0C4E) : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.deepPurple : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFF8416BC) : Colors.grey[850],
            ),
            padding: const EdgeInsets.all(20),
            child: Icon(icon, size: 36, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            gender,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
