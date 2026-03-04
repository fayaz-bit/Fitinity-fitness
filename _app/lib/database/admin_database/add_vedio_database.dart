import 'package:hive_flutter/hive_flutter.dart';

class AdminVideosDB {
  static const String _boxName = 'admin_video_fields';

  /// ✅ Open the Hive box
  static Future<Box<bool>> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<bool>(_boxName);
    }
    return Hive.box<bool>(_boxName);
  }

  /// ✅ Save the field status
  static Future<void> saveFields(bool isSaved) async {
    final box = await openBox();
    await box.put('isSaved', isSaved);
  }

  /// ✅ Get the field status
  static Future<bool> getFieldsStatus() async {
    final box = await openBox();
    return box.get('isSaved', defaultValue: false) ?? false;
  }

  /// ✅ Delete all fields
  static Future<void> deleteFields() async {
    final box = await openBox();
    await box.clear();
  }

  /// ✅ Close the box safely
  static Future<void> closeBox() async {
    if (Hive.isBoxOpen(_boxName)) {
      await Hive.box(_boxName).close();
    }
  }
}
