import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/add_meal.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/edit_meal.dart';

class MaintainCategoryController {
  Box? mealsBox;
  List<Map<String, String>> meals = [];

  Future<void> init(String categoryName, Function onReady) async {
    mealsBox = await Hive.openBox('${categoryName}_meals');

    meals = mealsBox!.values
        .map((e) => Map<String, String>.from(e as Map))
        .toList();

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
      await mealsBox!.add(result);
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
      await mealsBox!.putAt(index, updated);
      meals[index] = updated;
      onUpdate();
    }
  }

  Future<void> deleteMeal(int index, Function onUpdate) async {
    await mealsBox!.deleteAt(index);
    meals.removeAt(index);
    onUpdate();
  }
}
