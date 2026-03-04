import 'package:flutter/material.dart';

Widget heightPicker({
  required int selectedHeight,
  required Function(int) onHeightChange,
}) {
  return Expanded(
    child: ListWheelScrollView.useDelegate(
      itemExtent: 50,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: (index) {
        onHeightChange(100 + index);
      },
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: 151,
        builder: (context, index) {
          int height = 100 + index;
          bool isSelected = height == selectedHeight;

          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF8416BC) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "$height",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.white70,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
