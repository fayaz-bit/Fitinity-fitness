import 'package:_app/home/meal_plans/maintain_weight/breakfast/controllers/breakfast_maintain_controller.dart';
import 'package:_app/home/meal_plans/maintain_weight/breakfast/widget/breakfast_maintain_list.dart';
import 'package:flutter/material.dart';

class BreakfastMaintainScreen extends StatefulWidget {
  const BreakfastMaintainScreen({super.key});

  @override
  State<BreakfastMaintainScreen> createState() =>
      _BreakfastMaintainScreenState();
}

class _BreakfastMaintainScreenState extends State<BreakfastMaintainScreen> {
  late BreakfastMaintainController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller = BreakfastMaintainController();

    controller.init(() {
      setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Breakfast",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.purpleAccent),
            )
          : controller.meals.isEmpty
              ? const Center(
                  child: Text(
                    "No meals added yet",
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              : BreakfastMaintainList(
                  meals: controller.meals,
                  onEdit: (i) => controller.editMeal(
                    context,
                    i,
                    () => setState(() {}),
                  ),
                  onDelete: (i) => controller.deleteMeal(
                    i,
                    () => setState(() {}),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8416BC),
        onPressed: () => controller.addMeal(context, () => setState(() {})),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
