import 'package:_app/home/meal_plans/maintain_weight/admin_added_category/controllers/maintain_category_controller.dart';
import 'package:_app/home/meal_plans/maintain_weight/admin_added_category/widget/maintain_category_list.dart';
import 'package:flutter/material.dart';

class MaintainCategoryMealScreen extends StatefulWidget {
  final String categoryName;

  const MaintainCategoryMealScreen({
    super.key,
    required this.categoryName,
  });

  @override
  State<MaintainCategoryMealScreen> createState() =>
      _MaintainCategoryMealScreenState();
}

class _MaintainCategoryMealScreenState
    extends State<MaintainCategoryMealScreen> {
  late MaintainCategoryController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller = MaintainCategoryController();

    controller.init(widget.categoryName, () {
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
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
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
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                )
              : MaintainCategoryList(
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
