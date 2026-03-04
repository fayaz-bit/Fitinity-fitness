import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../models/admin_model.dart';

class WorkoutFlowController {
  late Box<AdminWorkoutCategory> categoryBox;

  final List<Map<String, String>> exercises = const [
    {"name": "Chest", "image": "assets/project1/workoutlevels/chest.jpg"},
    {"name": "Shoulder", "image": "assets/project1/workoutlevels/shoulder.jpg"},
    {"name": "Leg", "image": "assets/project1/workoutlevels/leg.jpg"},
    {"name": "Arms", "image": "assets/project1/workoutlevels/arms.jpg"},
    {"name": "Back", "image": "assets/project1/workoutlevels/back.jpg"},
  ];

  Future<void> init(VoidCallback onReady) async {
    categoryBox = Hive.box<AdminWorkoutCategory>('admin_workouts');
    onReady();
  }

  ValueListenable<Box<AdminWorkoutCategory>> listenable() {
    return categoryBox.listenable();
  }
}
