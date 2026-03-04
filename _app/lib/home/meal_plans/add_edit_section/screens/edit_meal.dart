import 'package:flutter/material.dart';
import 'package:_app/home/meal_plans/add_edit_section/controllers/add_meal_controller.dart';
import 'package:_app/home/meal_plans/add_edit_section/widget/meal_list.dart';

class EditMealPage extends StatefulWidget {
  final Map<String, String> meal;
  final int index;

  const EditMealPage({
    super.key,
    required this.meal,
    required this.index,
  });

  @override
  State<EditMealPage> createState() => _EditMealPageState();
}

class _EditMealPageState extends State<EditMealPage> {
  late MealController controller;

  @override
  void initState() {
    super.initState();
    controller = MealController(setState: setState, context: context);
    controller.initExistingMeal(widget.meal);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Edit Meal",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: MealForm(
          controller: controller,
          onSave: () => controller.saveEditedMeal(widget.index),
          buttonText: "Update Meal",
        ),
      ),
    );
  }
}
