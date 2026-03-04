import 'package:flutter/material.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/add_meal.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/edit_meal.dart';
import '../../../../../database/mealplans_database/wieght_gain_database.dart';

class BreakfastGainController {
  final db = BreakfastWeightGainDatabase();
  List<Map<String, String>> meals = [];

  Future<void> init(Function onReady) async {
    await db.initDB();
    meals = db.getAllMeals();
    onReady();
  }

  Future<void> addMeal(BuildContext context, Function onUpdate) async {
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
    final oldMeal = meals[index];

    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditMealPage(meal: oldMeal, index: index),
      ),
    );

    if (updated != null) {
      await db.updateMeal(index, updated);
      meals[index] = updated;
      onUpdate();
    }
  }

  Future<void> deleteMeal(int index, Function onUpdate) async {
    await db.deleteMeal(index);
    meals.removeAt(index);
    onUpdate();
  }
}
