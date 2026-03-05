import 'package:flutter/material.dart';
import 'package:_app/home/meal_plans/add_edit_section/controllers/add_meal_controller.dart';
import 'package:_app/home/meal_plans/add_edit_section/controllers/add_meal_validation.dart';

class MealForm extends StatelessWidget {
  final MealController controller;
  final VoidCallback onSave;
  final String buttonText;

  const MealForm({
    super.key,
    required this.controller,
    required this.onSave,
    this.buttonText = "Save",
  });

  static const violet = Color(0xFF8416BC);

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget sectionContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ------------------ BASIC INFO ------------------
        sectionTitle("Meal Information"),

        sectionContainer(
          child: Column(
            children: [
              MealInputWidgets.buildValidatedTextField(
                controller: controller.mealNameController,
                hint: "Meal title",
                errorHint: "Name can’t be empty",
                showError: controller.showMealError,
                onValidInput: () {
                  controller.setState(() => controller.showMealError = false);
                },
              ),
              const SizedBox(height: 14),
              MealInputWidgets.buildValidatedTextField(
                controller: controller.descriptionController,
                hint: "Meal description",
                maxLines: 3,
                errorHint: "Write description",
                showError: controller.showDescriptionError,
                onValidInput: () {
                  controller
                      .setState(() => controller.showDescriptionError = false);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        /// ------------------ INGREDIENTS ------------------
        sectionTitle("Ingredients"),

        sectionContainer(
          child: Column(
            children: [
              for (int i = 0; i < controller.ingredients.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: MealInputWidgets.buildSmallFieldValidated(
                          "Ingredient",
                          controller.ingredients[i]['ingredient']!,
                          controller.ingredientErrors[i]['ingredient']!,
                          errorHint: "Add ingredient name",
                          onValidInput: () {
                            controller.setState(() => controller
                                .ingredientErrors[i]['ingredient'] = false);
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        flex: 2,
                        child: MealInputWidgets.buildSmallFieldValidated(
                          "Qty",
                          controller.ingredients[i]['quantity']!,
                          controller.ingredientErrors[i]['quantity']!,
                          errorHint: "Add quantity",
                          onValidInput: () {
                            controller.setState(() => controller
                                .ingredientErrors[i]['quantity'] = false);
                          },
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: controller.ingredients[i]['unit']!.text.isEmpty
                              ? null
                              : controller.ingredients[i]['unit']!.text,
                          items: [
                            "g",
                            "kg",
                            "ml",
                            "L",
                            "tsp",
                            "tbsp",
                            "cup",
                            "piece",
                            "slice",
                          ].map((u) {
                            return DropdownMenuItem(
                              value: u,
                              child: Text(u),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.ingredients[i]['unit']!.text =
                                value ?? "";
                            controller.setState(() {
                              controller.ingredientErrors[i]['unit'] = false;
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          dropdownColor: Colors.grey[900],
                          decoration: InputDecoration(
                            labelText: "Unit",
                            labelStyle: const TextStyle(color: Colors.white70),
                            errorText: controller.ingredientErrors[i]['unit']!
                                ? "Add unit"
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white24)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: violet)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 28,
                        child: IconButton(
                          icon: const Icon(Icons.close,
                              color: Colors.white70, size: 20),
                          onPressed: () => controller.removeIngredient(i),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              MealInputWidgets.buildAddButton(
                "Add Ingredient",
                controller.addIngredient,
              ),
            ],
          ),
        ),

        const SizedBox(height: 22),

        /// ------------------ STEPS ------------------
        sectionTitle("Preparation Steps"),

        sectionContainer(
          child: Column(
            children: [
              for (int i = 0; i < controller.steps.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${i + 1}. ",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14)),
                      Expanded(
                        child: MealInputWidgets.buildTextFieldValidated(
                          controller.steps[i],
                          controller.stepErrors[i],
                          errorHint: "Add preparation step",
                          onValidInput: () {
                            controller.setState(
                                () => controller.stepErrors[i] = false);
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: Colors.white70, size: 20),
                        onPressed: () => controller.removeStep(i),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              MealInputWidgets.buildAddButton("Add Step", controller.addStep),
            ],
          ),
        ),

        const SizedBox(height: 22),

        /// ------------------ MACROS ------------------
        if (controller.enabledFields.containsValue(true)) ...[
          sectionTitle("Nutritional Macros"),
          sectionContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    if (controller.enabledFields['protein']!)
                      Expanded(
                        child: MealInputWidgets.buildMacroField(
                          "Proteins (g)",
                          controller.proteinController,
                        ),
                      ),
                    if (controller.enabledFields['protein']! &&
                        controller.enabledFields['carbs']!)
                      const SizedBox(width: 10),
                    if (controller.enabledFields['carbs']!)
                      Expanded(
                        child: MealInputWidgets.buildMacroField(
                          "Carbs (g)",
                          controller.carbsController,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (controller.enabledFields['fats']!)
                      Expanded(
                        child: MealInputWidgets.buildMacroField(
                          "Fats (g)",
                          controller.fatsController,
                        ),
                      ),
                    if (controller.enabledFields['fats']! &&
                        controller.enabledFields['calories']!)
                      const SizedBox(width: 10),
                    if (controller.enabledFields['calories']!)
                      Expanded(
                        child: MealInputWidgets.buildMacroField(
                          "Calories (kcal)",
                          controller.caloriesController,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 28),

        /// ------------------ SAVE BUTTON ------------------
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: violet,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
