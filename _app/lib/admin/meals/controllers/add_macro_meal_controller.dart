import 'package:_app/database/admin_database/meal_details_database.dart';
import 'package:flutter/material.dart';

class AddMealFieldsController {
  bool fieldsSelected = false;
  bool isLoading = true;

  // ✔ Load the saved status from DB and apply to UI
  Future<void> loadStatus(VoidCallback refresh) async {
    fieldsSelected = await AdminMealFieldsDB.getFieldsStatus();
    isLoading = false;
    refresh();
  }

  Future<void> saveFields(BuildContext context) async {
    if (!fieldsSelected) {
      _snack(
        context,
        "Please select the meal fields before saving!",
        Colors.orange,
      );
      return;
    }

    // ✔ Save TRUE to database
    await AdminMealFieldsDB.saveMealFields();

    _snack(context, "Meal fields saved successfully!", Colors.green);
  }

  Future<void> deleteFields(BuildContext context) async {
    // ✔ delete DB saved state
    await AdminMealFieldsDB.deleteFields();

    // ✔ remove selection from UI
    fieldsSelected = false;

    _snack(context, "Meal fields deleted!", Colors.red);
  }

  void _snack(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}
