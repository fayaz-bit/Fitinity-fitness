import 'dart:io';
import 'package:_app/database/admin_database/categorize_workout_database.dart';
import 'package:_app/models/admin_model.dart';
import 'package:flutter/material.dart';

class AddWorkoutCategoryController {
  final TextEditingController nameController = TextEditingController();
  File? pickedImage;

  void pickImage(File file) {
    pickedImage = file;
  }

  Future<void> saveCategory(BuildContext context) async {
    final name = nameController.text.trim();

    if (name.isEmpty || pickedImage == null) {
      snack(context, "Please enter name and select an image", Colors.redAccent);
      return;
    }

    final model = AdminWorkoutCategory(
      name: name,
      imagePath: pickedImage!.path,
    );

    final result = await AdminWorkoutCategoryDB.addCategory(model);

    if (result == "duplicate") {
      snack(context, "Category already exists!", Colors.red);
      return;
    }

    snack(context, "Workout category added!", Colors.green);

    nameController.clear();
    pickedImage = null;
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
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await AdminWorkoutCategoryDB.deleteCategory(index);
      snack(context, "Category deleted", Colors.redAccent);
      refresh();
    }
  }

  void snack(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }
}
