import 'package:hive_flutter/hive_flutter.dart';
part 'adminmodel.g.dart';

@HiveType(typeId: 2)
class AdminWorkoutCategory extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String imagePath;

  AdminWorkoutCategory({required this.name, required this.imagePath});
}
