import 'package:hive/hive.dart';
part 'workoutmodel.g.dart';

@HiveType(typeId: 1)
class Workout extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String duration;

  @HiveField(2)
  String sets;

  @HiveField(3)
  String reps;

  Workout({
    required this.name,
    required this.duration,
    required this.sets,
    required this.reps,
  });
}
