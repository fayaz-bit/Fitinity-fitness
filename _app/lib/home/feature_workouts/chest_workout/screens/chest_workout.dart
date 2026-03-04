import 'package:_app/home/feature_workouts/chest_workout/widget/chest_workout_list.dart';
import 'package:flutter/material.dart';
import '../controllers/chest_workout_controller.dart';

class ChestWorkoutScreen extends StatefulWidget {
  const ChestWorkoutScreen({super.key});

  @override
  State<ChestWorkoutScreen> createState() => _ChestWorkoutScreenState();
}

class _ChestWorkoutScreenState extends State<ChestWorkoutScreen> {
  late ChestWorkoutController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    controller = ChestWorkoutController();

    controller.init(() {
      setState(() => initialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'CHEST',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.white24, height: 1),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.listenable(),
        builder: (context, box, _) {
          return ChestWorkoutList(
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
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => controller.addWorkout(context, () => setState(() {})),
      ),
    );
  }
}
