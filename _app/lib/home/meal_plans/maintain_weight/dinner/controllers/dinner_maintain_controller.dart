import 'package:flutter/material.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/add_meal.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/edit_meal.dart';
import 'package:_app/database/mealplans_database/maintain_weight_database.dart';

class DinnerMaintainController {
  final DinnerDatabase db = DinnerDatabase();
  List<Map<String, String>> meals = [];

  Future<void> init(Function onReady) async {
    await db.init();
    meals = db.getAllMeals();
    onReady();
  }

  Future<void> addMeal(
    BuildContext context,
    Function onUpdate,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewMealPage()),
    );

    if (result != null) {
      await db.addMeal(result);
      meals.add(result);
      onUpdate();
    }
  }

  Future<void> editMeal(
    BuildContext context,
    int index,
    Function onUpdate,
  ) async {
    final existing = meals[index];

    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditMealPage(meal: existing, index: index),
      ),
    );

    if (updated != null) {
      await db.updateMeal(index, updated);
      meals[index] = updated;
      onUpdate();
    }
  }

  Future<void> deleteMeal(
    int index,
    Function onUpdate,
  ) async {
    await db.deleteMeal(index);
    meals.removeAt(index);
    onUpdate();
  }
}
