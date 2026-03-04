import 'package:_app/home/feature_workouts/add_edit_options/widget/workout_form.dart';
import 'package:flutter/material.dart';
import '../controllers/edit_workout_controller.dart';

class EditWorkoutScreen extends StatefulWidget {
  final Map<String, String> existingWorkout;

  const EditWorkoutScreen({super.key, required this.existingWorkout});

  @override
  State<EditWorkoutScreen> createState() => _EditWorkoutScreenState();
}

class _EditWorkoutScreenState extends State<EditWorkoutScreen> {
  late EditWorkoutController controller;

  @override
  void initState() {
    super.initState();
    controller = EditWorkoutController(widget.existingWorkout);

    //  Load admin video settings and rebuild
    controller.loadVideoSettings().then((_) {
      if (mounted) {
        setState(() {});
      }
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
          "Edit Workout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: WorkoutForm(
          controller: controller,
          isEdit: true,
        ),
      ),
    );
  }
}
