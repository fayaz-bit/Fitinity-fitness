import 'package:_app/home/meal_plans/add_edit_section/screens/add_meal.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/edit_meal.dart';
import 'package:flutter/material.dart';
import '../../../../../database/mealplans_database/weight_loss_database.dart';

class LunchLossController {
  final LunchWeightLossDatabase db = LunchWeightLossDatabase();
  List<Map<String, String>> meals = [];

  Future<void> init(Function onReady) async {
    await db.initDB();
    meals = db.getAllMeals();
    onReady();
  }

  Future<void> addMeal(BuildContext context, Function refresh) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewMealPage()),
    );

    if (result != null) {
      await db.addMeal(result);
      meals.add(result);
      refresh();
    }
  }

  Future<void> editMeal(
      BuildContext context, int index, Function refresh) async {
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
      refresh();
    }
  }

  Future<void> deleteMeal(int index, Function refresh) async {
    await db.deleteMeal(index);
    meals.removeAt(index);
    refresh();
  }
}
