import 'package:_app/database/admin_database/categorize_meals_database.dart';
import 'package:_app/models/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategorizeMealsController {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  int selectedIconIndex = 0;
  Future<Box<MealCategory>>? boxFuture;

  final List<IconData> icons = [
    Icons.restaurant,
    Icons.egg,
    Icons.coffee,
    Icons.ramen_dining,
    Icons.local_drink,
  ];

  Future<void> openBox(VoidCallback refresh) async {
    boxFuture = MealCategoryDB.openBox();
    refresh();
  }

  Future<void> saveCategory(BuildContext context, VoidCallback refresh) async {
    final name = nameController.text.trim();
    final desc = descController.text.trim();

    if (name.isEmpty || desc.isEmpty) {
      _snack(context, "Please fill all fields", Colors.redAccent);
      return;
    }

    final category = MealCategory(
      name: name,
      description: desc,
      iconIndex: selectedIconIndex,
    );

    final result = await MealCategoryDB.addCategory(category);

    if (result == "duplicate") {
      _snack(context, "Category already exists!", Colors.orangeAccent);
      return;
    }

    _snack(context, "Meal category added!", Colors.green);

    nameController.clear();
    descController.clear();
    selectedIconIndex = 0;
    refresh();
  }

  Future<void> deleteCategory(
      BuildContext context, int index, VoidCallback refresh) async {
    final confirm = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        title: const Text("Delete Category",
            style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure?",
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text("Delete", style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm == true) {
      await MealCategoryDB.deleteCategory(index);
      _snack(context, "Category deleted", Colors.redAccent);
      refresh();
    }
  }

  void _snack(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }
}
