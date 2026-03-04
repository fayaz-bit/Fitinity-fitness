import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../add_edit_options/screens/new_workout_screen.dart';
import '../../add_edit_options/screens/edit_workout_screen.dart';
import '../../../../database/featureworkouts_database/back_database.dart';

class BackWorkoutController {
  late BackWorkoutDatabase db;

  BackWorkoutController() {
    db = BackWorkoutDatabase();
  }

  Future<void> init(VoidCallback refresh) async {
    await db.init();
    refresh(); // notify UI
  }

  ValueListenable<Box> listenable() {
    return db.box.listenable();
  }

  Future<void> addWorkout(BuildContext context, VoidCallback refresh) async {
    final newWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NewWorkoutScreen(
          workout: null,
          existingWorkout: {},
        ),
      ),
    );

    if (newWorkout != null && newWorkout is Map<String, String>) {
      await db.addWorkout(newWorkout);
      refresh();
    }
  }

  Future<void> editWorkout(
      BuildContext context, int index, VoidCallback refresh) async {
    final oldWorkout = Map<String, String>.from(db.box.getAt(index));

    final updatedWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditWorkoutScreen(existingWorkout: oldWorkout),
      ),
    );

    if (updatedWorkout != null && updatedWorkout is Map<String, String>) {
      await db.updateWorkout(index, updatedWorkout);
      refresh();
    }
  }

  Future<void> deleteWorkout(int index, VoidCallback refresh) async {
    await db.deleteWorkout(index);
    refresh();
  }
}
