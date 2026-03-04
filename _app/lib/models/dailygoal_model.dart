import 'package:hive/hive.dart';

part 'dailygoalmodel.g.dart';

@HiveType(typeId: 6) // choose a unique typeId not used elsewhere
class DailyWorkout extends HiveObject {
  @HiveField(0)
  final String title; // workout text (what user typed)

  @HiveField(1)
  final DateTime date; // optional: to group by day

  DailyWorkout({
    required this.title,
    required this.date,
  });
}
