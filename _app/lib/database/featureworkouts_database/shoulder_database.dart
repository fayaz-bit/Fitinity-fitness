import 'package:hive_flutter/hive_flutter.dart';

class ShoulderWorkoutDatabase {
  Box? _workoutsBox;
  String? currentUserId;

  Future<void> init() async {
    await Hive.initFlutter();
    var sessionBox = await Hive.openBox('session');
    currentUserId = sessionBox.get('currentUserId');
    _workoutsBox = await Hive.openBox('${currentUserId}_shoulderWorkouts');
  }

  Box get box => _workoutsBox!;

  List<Map<String, String>> getAllWorkouts() {
    return _workoutsBox!.values
        .map((e) => Map<String, String>.from(e))
        .toList();
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
