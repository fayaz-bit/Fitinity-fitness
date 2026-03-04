import 'package:flutter/material.dart';

Widget weightPicker({
  required int selectedWeight,
  required Function(int) onWeightChange,
}) {
  return ListWheelScrollView.useDelegate(
    itemExtent: 50,
    physics: const FixedExtentScrollPhysics(),
    onSelectedItemChanged: (index) {
      onWeightChange(30 + index);
    },
    childDelegate: ListWheelChildBuilderDelegate(
      childCount: 151,
      builder: (context, index) {
        int weight = 30 + index;
        bool isSelected = weight == selectedWeight;

        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? Colors.deepPurple : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "$weight",
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
  );
}
