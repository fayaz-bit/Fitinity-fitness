import 'package:_app/database/mealplans_database/add_meal_database.dart';
import 'package:flutter/material.dart';

class MealController {
  final void Function(void Function()) setState;
  final BuildContext context;

  MealController({required this.setState, required this.context});

  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController carbsController = TextEditingController();
  final TextEditingController fatsController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  /// Ingredient object structure:
  /// {
  ///   "ingredient": TextEditingController(),
  ///   "quantity": TextEditingController(),
  ///   "unit": TextEditingController()   ← dropdown writes value here
  /// }
  List<Map<String, TextEditingController>> ingredients = [];
  List<TextEditingController> steps = [];

  List<Map<String, bool>> ingredientErrors = [];
  List<bool> stepErrors = [];

  Map<String, bool> enabledFields = {
    'protein': false,
    'carbs': false,
    'fats': false,
    'calories': false,
  };

  bool showMealError = false;
  bool showDescriptionError = false;

  Future<void> init() async {
    final fields = await MealFieldDB.getEnabledFields();
    setState(() {
      enabledFields = fields;
    });
  }

  /// Load existing meal data
  void initExistingMeal(Map<String, String> meal) async {
    final fields = await MealFieldDB.getEnabledFields();
    enabledFields = fields;

    ingredients.clear();
    ingredientErrors.clear();
    steps.clear();
    stepErrors.clear();

    mealNameController.text = meal['name'] ?? "";
    descriptionController.text = meal['description'] ?? "";

    if (enabledFields['protein']!)
      proteinController.text = meal['protein'] ?? "";
    if (enabledFields['carbs']!) carbsController.text = meal['carbs'] ?? "";
    if (enabledFields['fats']!) fatsController.text = meal['fats'] ?? "";
    if (enabledFields['calories']!)
      caloriesController.text = meal['calories'] ?? "";

    /// INGREDIENT PARSING
    try {
      final ingData = meal['ingredients'];

      if (ingData != null && ingData.startsWith("[") && ingData.endsWith("]")) {
        final listString = ingData.substring(1, ingData.length - 1).trim();

        if (listString.isNotEmpty) {
          final rawItems = listString.split('},');

          for (var item in rawItems) {
            if (item.trim().isEmpty) continue;

            final cleaned = item.replaceAll("{", "").replaceAll("}", "").trim();
            if (cleaned.isEmpty) continue;

            final parts = cleaned.split(',').map((e) => e.trim()).toList();

            String ing = parts.isNotEmpty
                ? parts[0].replaceAll("ingredient:", "").trim()
                : "";
            String qty = parts.length > 1
                ? parts[1].replaceAll("quantity:", "").trim()
                : "";
            String unit =
                parts.length > 2 ? parts[2].replaceAll("unit:", "").trim() : "";

            ingredients.add({
              'ingredient': TextEditingController(text: ing),
              'quantity': TextEditingController(text: qty),
              'unit': TextEditingController(text: unit), // dropdown uses this
            });

            ingredientErrors.add({
              'ingredient': false,
              'quantity': false,
              'unit': false,
            });
          }
        }
      }
    } catch (_) {}

    /// STEPS PARSING
    try {
      final stepsData = meal['steps'];

      if (stepsData != null &&
          stepsData.startsWith("[") &&
          stepsData.endsWith("]")) {
        final listString = stepsData.substring(1, stepsData.length - 1).trim();

        if (listString.isNotEmpty) {
          final rawSteps = listString.split(',');

          for (var s in rawSteps) {
            if (s.trim().isEmpty) continue;

            steps.add(TextEditingController(text: s.trim()));
            stepErrors.add(false);
          }
        }
      }
    } catch (_) {}

    setState(() {});
  }

  /// ADD / REMOVE INGREDIENTS
  void addIngredient() {
    setState(() {
      ingredients.add({
        'ingredient': TextEditingController(),
        'quantity': TextEditingController(),
        'unit': TextEditingController(), // controlled by dropdown UI
      });

      ingredientErrors.add({
        'ingredient': false,
        'quantity': false,
        'unit': false,
      });
    });
  }

  void removeIngredient(int index) {
    setState(() {
      ingredients[index]['ingredient']?.dispose();
      ingredients[index]['quantity']?.dispose();
      ingredients[index]['unit']?.dispose();

      ingredients.removeAt(index);
      ingredientErrors.removeAt(index);
    });
  }

  /// ADD / REMOVE STEPS
  void addStep() {
    setState(() {
      steps.add(TextEditingController());
      stepErrors.add(false);
    });
  }

  void removeStep(int index) {
    setState(() {
      steps[index].dispose();
      steps.removeAt(index);
      stepErrors.removeAt(index);
    });
  }

  /// VALIDATION
  bool _validateInputs() {
    final name = mealNameController.text.trim();
    final desc = descriptionController.text.trim();

    showMealError = name.isEmpty;
    showDescriptionError = desc.isEmpty;

    bool ingErrorFound = false;
    bool stepErrorFound = false;

    for (int i = 0; i < ingredients.length; i++) {
      final ing = ingredients[i];

      bool ingErr = ing['ingredient']!.text.trim().isEmpty;
      bool qtyErr = ing['quantity']!.text.trim().isEmpty;
      bool unitErr = ing['unit']!.text.trim().isEmpty;

      ingredientErrors[i] = {
        'ingredient': ingErr,
        'quantity': qtyErr,
        'unit': unitErr,
      };

      if (ingErr || qtyErr || unitErr) ingErrorFound = true;
    }

    for (int i = 0; i < steps.length; i++) {
      bool stErr = steps[i].text.trim().isEmpty;
      stepErrors[i] = stErr;
      if (stErr) stepErrorFound = true;
    }

    setState(() {});
    return !(showMealError ||
        showDescriptionError ||
        ingErrorFound ||
        stepErrorFound);
  }

  /// RETURN FINAL MEAL MAP
  Map<String, String> _buildMealMap() {
    Map<String, dynamic> map = {
      'name': mealNameController.text.trim(),
      'description': descriptionController.text.trim(),
      'ingredients': ingredients
          .map((e) => {
                'ingredient': e['ingredient']!.text,
                'quantity': e['quantity']!.text,
                'unit': e['unit']!.text, // comes from dropdown
              })
          .toList(),
      'steps': steps.map((e) => e.text).toList(),
    };

    if (enabledFields['protein']!) map['protein'] = proteinController.text;
    if (enabledFields['carbs']!) map['carbs'] = carbsController.text;
    if (enabledFields['fats']!) map['fats'] = fatsController.text;
    if (enabledFields['calories']!) map['calories'] = caloriesController.text;

    return map.map((key, value) => MapEntry(key, value.toString()));
  }

  void saveMeal() {
    if (!_validateInputs()) return;
    Navigator.pop(context, _buildMealMap());
  }

  void saveEditedMeal(int index) {
    if (!_validateInputs()) return;
    Navigator.pop(context, _buildMealMap());
  }

  /// CLEANUP
  void dispose() {
    mealNameController.dispose();
    descriptionController.dispose();
    proteinController.dispose();
    carbsController.dispose();
    fatsController.dispose();
    caloriesController.dispose();

    for (final ing in ingredients) {
      ing['ingredient']?.dispose();
      ing['quantity']?.dispose();
      ing['unit']?.dispose();
    }

    for (final st in steps) {
      st.dispose();
    }
  }
}
