import 'package:flutter/material.dart';
import 'package:_app/onboarding_screens/user_info/screens/wieght_selection_screen.dart';

class HeightSelectionController {
  int selectedHeight = 155;

  void updateHeight(int value) {
    selectedHeight = value;
  }

  void goToNext(BuildContext context, String gender) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeightSelection(
          gender: gender,
          height: selectedHeight.toString(),
        ),
      ),
    );
  }
}
