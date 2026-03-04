import 'package:flutter/material.dart';

enum BmiCategory { underweight, normal, overweight }

class BmiController extends ChangeNotifier {
  final TextEditingController bmiTextController = TextEditingController();

  double _bmiValue = 0;
  double get bmiValue => _bmiValue;

  bool hasResult = false;

  int calories = 0;
  double water = 0;
  int protein = 0;

  BmiCategory? category;

  /// 🔥 NEW METHOD (Age + Height + Weight)
  void calculateFromInputs({
    required double heightCm,
    required double weightKg,
    required int age,
  }) {
    final height = heightCm / 100;
    _bmiValue = weightKg / (height * height);

    _applyCategoryLogic(age);
    notifyListeners();
  }

  /// If using manual BMI input
  void calculateFromBmi() {
    final input = double.tryParse(bmiTextController.text);
    if (input == null) return;

    _bmiValue = input;
    _applyCategoryLogic(25); // default age if unknown
    notifyListeners();
  }

  void _applyCategoryLogic(int age) {
    hasResult = true;

    if (_bmiValue < 18.5) {
      category = BmiCategory.underweight;
      calories = age < 25 ? 2400 : 2200;
      water = 2.5;
      protein = 120;
    } else if (_bmiValue < 25) {
      category = BmiCategory.normal;
      calories = age < 30 ? 2600 : 2500;
      water = 3.0;
      protein = 150;
    } else {
      category = BmiCategory.overweight;
      calories = age < 30 ? 2100 : 2000;
      water = 2.5;
      protein = 130;
    }
  }

  void disposeController() {
    bmiTextController.dispose();
  }

  String get bmiMessage {
    if (category == null) return "";

    switch (category!) {
      case BmiCategory.underweight:
        return "Your BMI indicates you are underweight. It is advised to focus on nutrient-dense meals and strength training to build healthy body mass.";
      case BmiCategory.normal:
        return "Your BMI is within the healthy range. Maintain a balanced diet and consistent workout routine to sustain your fitness level.";
      case BmiCategory.overweight:
        return "Your BMI indicates overweight. A structured workout plan and mindful nutrition can help improve your overall health.";
    }
  }
}
