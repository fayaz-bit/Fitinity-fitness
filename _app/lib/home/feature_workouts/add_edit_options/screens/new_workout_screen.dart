import 'package:_app/home/feature_workouts/add_edit_options/widget/workout_form.dart';
import 'package:flutter/material.dart';
import '../controllers/new_workout_controller.dart';

class NewWorkoutScreen extends StatefulWidget {
  final Map<String, String>? workout;

  const NewWorkoutScreen(
      {super.key, this.workout, required Map existingWorkout});

  @override
  State<NewWorkoutScreen> createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  late NewWorkoutController controller;

  @override
  void initState() {
    super.initState();
    controller = NewWorkoutController(widget.workout);

    //  Load admin video settings and rebuild UI
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
          "New Workout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: WorkoutForm(
          controller: controller,
          isEdit: false,
        ),
      ),
    );
  }
}
