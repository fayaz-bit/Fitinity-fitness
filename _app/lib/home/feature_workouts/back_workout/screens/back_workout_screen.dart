import 'package:_app/home/feature_workouts/back_workout/widget/back_workout_list.dart';
import 'package:flutter/material.dart';
import '../controllers/back_workout_controller.dart';

class BackWorkoutScreen extends StatefulWidget {
  const BackWorkoutScreen({super.key});

  @override
  State<BackWorkoutScreen> createState() => _BackWorkoutScreenState();
}

class _BackWorkoutScreenState extends State<BackWorkoutScreen> {
  late BackWorkoutController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    controller = BackWorkoutController();

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
          'BACK',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: Colors.white24, height: 1),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.listenable(),
        builder: (context, box, _) {
          return BackWorkoutList(
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
        onPressed: () => controller.addWorkout(
          context,
          () => setState(() {}),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
