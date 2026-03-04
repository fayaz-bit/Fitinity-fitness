import 'package:hive/hive.dart';

part 'mealdetailmodel.g.dart';

@HiveType(typeId: 5)
class MealFieldModel extends HiveObject {
  @HiveField(0)
  bool macrosEnabled;

  @HiveField(1)
  bool proteinEnabled;

  @HiveField(2)
  bool carbsEnabled;

  @HiveField(3)
  bool fatsEnabled;

  @HiveField(4)
  bool caloriesEnabled;

  MealFieldModel({
    this.macrosEnabled = false,
    this.proteinEnabled = false,
    this.carbsEnabled = false,
    this.fatsEnabled = false,
    this.caloriesEnabled = false,
  });
}
