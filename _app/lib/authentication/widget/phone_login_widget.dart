import 'package:flutter/material.dart';

Widget buildPhoneLoginField({
  required TextEditingController controller,
  required IconData icon,
  required String hintText,
  required String? errorText,
  required VoidCallback onTyping,
  bool isPassword = false,
}) {
  bool isError = errorText != null;

  return TextField(
    controller: controller,
    obscureText: isPassword,
    style: const TextStyle(color: Colors.white),
    onChanged: (value) {
      if (value.trim().isNotEmpty) {
        onTyping();
      }
    },
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white),
      hintText: isError ? errorText : hintText,
      hintStyle: TextStyle(
        color: isError ? Colors.redAccent : Colors.white70,
      ),
      filled: true,
      fillColor: const Color(0xFF2A2A2A),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isError ? const Color(0xFF8416BC) : Colors.transparent,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isError ? const Color(0xFF8416BC) : Colors.transparent,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
