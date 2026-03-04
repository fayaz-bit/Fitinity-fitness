class FitnessGoalController {
  String? selectedGoal;

  void selectGoal(String goal) {
    selectedGoal = goal;
  }

  bool isSelected(String goal) {
    return selectedGoal == goal;
  }

  bool get canContinue => selectedGoal != null;
}
