class FitnessLevelController {
  String? selectedLevel;

  void selectLevel(String level) {
    selectedLevel = level;
  }

  bool isSelected(String level) {
    return selectedLevel == level;
  }

  bool get canContinue => selectedLevel != null;
}
