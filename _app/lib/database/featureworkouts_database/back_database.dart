import 'package:hive_flutter/hive_flutter.dart';

class BackWorkoutDatabase {
  Box? _workoutsBox;
  String? currentUserId;
  bool isInitialized = false;

  Box get box => _workoutsBox!;

  Future<void> init() async {
    await Hive.initFlutter();
    var sessionBox = await Hive.openBox('session');
    currentUserId = sessionBox.get('currentUserId');
    _workoutsBox = await Hive.openBox('${currentUserId}_backWorkouts');
    isInitialized = true;
  }

  Future<void> addWorkout(Map<String, String> workout) async {
    await _workoutsBox!.add(workout);
  }

  Future<void> updateWorkout(int index, Map<String, String> workout) async {
    await _workoutsBox!.putAt(index, workout);
  }

  Future<void> deleteWorkout(int index) async {
    await _workoutsBox!.deleteAt(index);
  }
}
