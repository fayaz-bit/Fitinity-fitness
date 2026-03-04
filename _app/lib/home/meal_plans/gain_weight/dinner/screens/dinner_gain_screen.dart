import 'package:_app/home/meal_plans/gain_weight/dinner/widget/dinner_gain_list.dart';
import 'package:flutter/material.dart';
import '../controllers/dinner_gain_controller.dart';

class DinnerGainScreen extends StatefulWidget {
  const DinnerGainScreen({super.key});

  @override
  State<DinnerGainScreen> createState() => _DinnerGainScreenState();
}

class _DinnerGainScreenState extends State<DinnerGainScreen> {
  late DinnerGainController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller = DinnerGainController();

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
          "Dinner (Gain)",
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
              : DinnerGainList(
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
        onPressed: () => controller.addMeal(
          context,
          () => setState(() {}),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
