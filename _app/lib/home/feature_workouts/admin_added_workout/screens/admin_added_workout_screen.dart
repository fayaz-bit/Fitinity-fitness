import 'package:_app/home/feature_workouts/admin_added_workout/widget/category_workout_list.dart';
import 'package:flutter/material.dart';
import '../controllers/category_workout_controller.dart';

class CategoryWorkoutScreen extends StatefulWidget {
  final String categoryName;

  const CategoryWorkoutScreen({
    super.key,
    required this.categoryName,
  });

  @override
  State<CategoryWorkoutScreen> createState() => _CategoryWorkoutScreenState();
}

class _CategoryWorkoutScreenState extends State<CategoryWorkoutScreen> {
  late CategoryWorkoutController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    controller = CategoryWorkoutController();

    controller.init(widget.categoryName, () {
      setState(() => initialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.purple),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.categoryName.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(color: Colors.white24, height: 1),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.listenable(),
        builder: (context, box, _) {
          return CategoryWorkoutList(
            box: box,
            onEdit: (i) => controller.editWorkout(
              context,
              i,
              () => setState(() {}),
            ),
            onDelete: (i) => controller.deleteWorkout(
              i,
              () => setState(() {}),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8416BC),
        onPressed: () {
          controller.addWorkout(context, () => setState(() {}));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
