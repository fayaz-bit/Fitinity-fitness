import 'package:_app/database/featureworkouts_database/adminadded_category_database.dart';
import 'package:_app/home/feature_workouts/add_edit_options/screens/edit_workout_screen.dart';
import 'package:_app/home/feature_workouts/add_edit_options/screens/new_workout_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryWorkoutController {
  Box? box;
  String? userId;

  Future<void> init(String categoryName, VoidCallback onReady) async {
    await DatabaseService.init();
    userId = await DatabaseService.getCurrentUserId();

    if (userId != null) {
      box = await DatabaseService.openCategoryWorkoutsBox(
        userId!,
        categoryName,
      );
      onReady();
    }
  }

  ValueListenable<Box> listenable() {
    return box!.listenable();
  }

  Future<void> addWorkout(
    BuildContext context,
    VoidCallback refresh,
  ) async {
    final newWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NewWorkoutScreen(existingWorkout: {}),
      ),
    );

    if (newWorkout is Map<String, dynamic>) {
      await DatabaseService.addWorkout(box!, newWorkout);
      refresh();
    }
  }

  Future<void> editWorkout(
    BuildContext context,
    int index,
    VoidCallback refresh,
  ) async {
    final oldWorkoutRaw = Map<String, dynamic>.from(box!.getAt(index));

    final oldWorkout = oldWorkoutRaw.map(
      (key, value) => MapEntry(key, value?.toString() ?? ""),
    );

    final updatedWorkout = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditWorkoutScreen(existingWorkout: oldWorkout),
      ),
    );

    if (updatedWorkout is Map<String, dynamic>) {
      await DatabaseService.updateWorkout(box!, index, updatedWorkout);
      refresh();
    }
  }

  Future<void> deleteWorkout(
    int index,
    VoidCallback refresh,
  ) async {
    await DatabaseService.deleteWorkout(box!, index);
    refresh();
  }
}
