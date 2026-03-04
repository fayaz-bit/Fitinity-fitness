import 'package:_app/onboarding_screens/user_info/screens/age_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:_app/models/usermodel.dart';

class WeightSelectionController {
  int selectedWeight = 50;

  void updateWeight(int value) {
    selectedWeight = value;
  }

  Future<void> saveAndContinue(
    BuildContext context,
    String gender,
    String height,
  ) async {
    var box = await Hive.openBox<UserModel>('users');
    var user = box.get('currentUser');

    if (user != null) {
      user.weight = selectedWeight;
      await user.save();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AgeSelectionScreen(
          gender: gender,
          height: height,
          weight: selectedWeight.toString(),
        ),
      ),
    );
  }
}
