import 'package:flutter/material.dart';

Widget buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  );
}

Widget buildInputField(
  TextEditingController controller,
  String hint, {
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: const Color(0xff232127),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
    ),
  );
}

Widget buildIconsRow({
  required List<IconData> icons,
  required int selectedIndex,
  required Function(int) onSelect,
}) {
  return Row(
    children: List.generate(icons.length, (index) {
      final selected = index == selectedIndex;
      return Padding(
        padding: const EdgeInsets.only(right: 18),
        child: GestureDetector(
          onTap: () => onSelect(index),
          child: CircleAvatar(
            backgroundColor:
                selected ? const Color(0xFF9A4DFF) : const Color(0xFF232127),
            radius: 26,
            child: Icon(icons[index], color: Colors.white, size: 28),
          ),
        ),
      );
    }),
  );
}
