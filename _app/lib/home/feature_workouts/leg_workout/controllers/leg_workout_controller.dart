import 'package:_app/home/feature_workouts/add_edit_options/screens/edit_workout_screen.dart';
import 'package:_app/home/feature_workouts/add_edit_options/screens/new_workout_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../database/featureworkouts_database/leg_database.dart';

class LegWorkoutController {
  late LegWorkoutDatabase db;

  Future<void> init(VoidCallback onReady) async {
    db = LegWorkoutDatabase();
    await db.init();
    onReady();
  }

  ValueListenable<Box> listenable() {
    return db.box.listenable();
  }

  Future<void> addWorkout(BuildContext context, VoidCallback refresh) async {
    final newWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NewWorkoutScreen(existingWorkout: {}),
      ),
    );

    if (newWorkout is Map<String, String>) {
      await db.addWorkout(newWorkout);
      refresh();
    }
  }

  Future<void> editWorkout(
    BuildContext context,
    int index,
    VoidCallback refresh,
  ) async {
    final oldWorkout = Map<String, String>.from(db.box.getAt(index));

    final updatedWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditWorkoutScreen(existingWorkout: oldWorkout),
      ),
    );

    if (updatedWorkout is Map<String, String>) {
      await db.updateWorkout(index, updatedWorkout);
      refresh();
    }
  }

  Future<void> deleteWorkout(
    int index,
    VoidCallback refresh,
  ) async {
    await db.deleteWorkout(index);
    refresh();
  }
}
