import 'package:hive/hive.dart';

part 'vediomodel.g.dart';

@HiveType(typeId: 3)
class AdminVideoModel extends HiveObject {
  @HiveField(0)
  String workoutName;

  @HiveField(1)
  bool videoTitleEnabled;

  @HiveField(2)
  bool videoUrlEnabled;

  @HiveField(3)
  bool videoFileEnabled;

  AdminVideoModel({
    required this.workoutName,
    this.videoTitleEnabled = false,
    this.videoUrlEnabled = false,
    this.videoFileEnabled = false,
  });
}
