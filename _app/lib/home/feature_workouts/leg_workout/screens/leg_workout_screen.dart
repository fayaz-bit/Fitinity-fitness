import 'package:_app/home/feature_workouts/leg_workout/widget/leg_workout_list.dart';
import 'package:flutter/material.dart';
import '../controllers/leg_workout_controller.dart';

class LegWorkoutScreen extends StatefulWidget {
  const LegWorkoutScreen({super.key});

  @override
  State<LegWorkoutScreen> createState() => _LegWorkoutScreenState();
}

class _LegWorkoutScreenState extends State<LegWorkoutScreen> {
  late LegWorkoutController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    controller = LegWorkoutController();

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
          'LEGS',
          style: TextStyle(
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
          return LegWorkoutList(
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
        onPressed: () => controller.addWorkout(context, () => setState(() {})),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
