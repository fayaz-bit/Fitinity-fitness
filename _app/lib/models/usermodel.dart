import 'package:hive/hive.dart';
import 'workoutmodel.dart';

part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  int age;

  @HiveField(4)
  int height;

  @HiveField(5)
  int weight;

  @HiveField(6)
  String gender;

  @HiveField(7)
  String phone;

  @HiveField(8)
  String imagePath;

  @HiveField(9)
  String? password;

  @HiveField(10)
  List<Workout> workouts;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
    required this.phone,
    required this.imagePath,
    this.password,
    List<Workout>? workouts,
  }) : workouts = workouts ?? [];
}
