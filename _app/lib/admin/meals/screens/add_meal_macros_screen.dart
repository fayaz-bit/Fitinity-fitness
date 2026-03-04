import 'package:_app/admin/meals/widget/macro_widget.dart';
import 'package:flutter/material.dart';
import '../controllers/add_macro_meal_controller.dart';

class AddMealFieldsPage extends StatefulWidget {
  const AddMealFieldsPage({super.key});

  @override
  State<AddMealFieldsPage> createState() => _AddMealFieldsPageState();
}

class _AddMealFieldsPageState extends State<AddMealFieldsPage> {
  final AddMealFieldsController controller = AddMealFieldsController();

  @override
  void initState() {
    super.initState();

    controller.fieldsSelected = false;

    controller.loadStatus(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF9A4DFF)),
        ),
      );
    }

    final borderColor = controller.fieldsSelected
        ? const Color(0xFF9A4DFF)
        : Colors.grey.shade800;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Meal Details'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => setState(() => controller.fieldsSelected = true),
          child: Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(
              minHeight: 160,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Nutritional Macros",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: macroField("Proteins (g)", "e.g., 30")),
                    const SizedBox(width: 10),
                    Expanded(child: macroField("Carbs (g)", "e.g., 45")),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: macroField("Fats (g)", "e.g., 15")),
                    const SizedBox(width: 10),
                    Expanded(child: macroField("Calories (kcal)", "e.g., 450")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: controller.fieldsSelected
                  ? () async {
                      await controller.saveFields(context);
                      Future.delayed(const Duration(milliseconds: 300), () {
                        Navigator.pop(context);
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.fieldsSelected
                    ? const Color(0xFF9A4DFF)
                    : Colors.grey,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Add macro fields",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                await controller.deleteFields(context);
                Future.delayed(const Duration(milliseconds: 300), () {
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text(
                "Delete macros fields",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
