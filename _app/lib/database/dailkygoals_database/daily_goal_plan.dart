import 'package:hive_flutter/hive_flutter.dart';
import 'package:_app/home/calculator/controllers/bmi_controller.dart';

class PlanStatusDatabase {
  static const String boxName = "plan_status";
  static const String activeKey = "active";
  static const String categoryKey = "category";

  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(boxName);
  }

  bool get isPlanActive => _box.get(activeKey, defaultValue: false);

  BmiCategory? get savedCategory {
    final stored = _box.get(categoryKey);
    if (stored == null) return null;

    return BmiCategory.values.firstWhere(
      (e) => e.name == stored,
    );
  }

  Future<void> activatePlan(BmiCategory category) async {
    await _box.put(activeKey, true);
    await _box.put(categoryKey, category.name); // store enum as string
  }

  Future<void> deactivatePlan() async {
    await _box.delete(activeKey);
    await _box.delete(categoryKey);
  }
}
