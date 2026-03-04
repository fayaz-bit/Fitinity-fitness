import 'package:hive/hive.dart';

part 'mealmodel.g.dart';

@HiveType(typeId: 4)
class MealCategory extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final int iconIndex;

  MealCategory({
    required this.name,
    required this.description,
    required this.iconIndex,
  });
}
