import 'package:_app/home/feature_workouts/arms_workout/widget/arms_workout_list.dart';
import 'package:flutter/material.dart';
import '../controllers/arms_workout_controller.dart';

class ArmsWorkoutScreen extends StatefulWidget {
  const ArmsWorkoutScreen({super.key});

  @override
  State<ArmsWorkoutScreen> createState() => _ArmsWorkoutScreenState();
}

class _ArmsWorkoutScreenState extends State<ArmsWorkoutScreen> {
  late ArmsWorkoutController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    controller = ArmsWorkoutController();

    controller.init(() {
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
        title: const Text(
          'ARMS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.listenable(),
        builder: (context, box, _) {
          return ArmsWorkoutList(
            box: box,
            onEdit: (i) =>
                controller.editWorkout(context, i, () => setState(() {})),
            onDelete: (i) => controller.deleteWorkout(i, () => setState(() {})),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8416BC),
        onPressed: () => controller.addWorkout(context, () => setState(() {})),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
