import 'package:flutter/material.dart';
import 'package:_app/home/meal_plans/add_edit_section/controllers/add_meal_controller.dart';
import 'package:_app/home/meal_plans/add_edit_section/widget/meal_list.dart';

class NewMealPage extends StatefulWidget {
  const NewMealPage({super.key});

  @override
  State<NewMealPage> createState() => _NewMealPageState();
}

class _NewMealPageState extends State<NewMealPage> {
  late MealController controller;

  @override
  void initState() {
    super.initState();
    controller = MealController(setState: setState, context: context);
    controller.init();
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
        title: const Text("New Meal",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: MealForm(
          controller: controller,
          onSave: controller.saveMeal,
          buttonText: "Save",
        ),
      ),
    );
  }
}
