import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static const String adminBoxName = 'admin_video_fields';

  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
  }

  /// Get admin video settings
  static Future<Map<String, bool>> getAdminVideoSettings() async {
    final box = await Hive.openBox<bool>(adminBoxName);
    final isSaved = box.get("isSaved") ?? false;
    return {
      'videoTitleEnabled': isSaved,
      'videoUrlEnabled': isSaved,
      'videoFileEnabled': isSaved,
    };
  }

  /// Save admin video settings
  static Future<void> saveAdminVideoSettings(bool value) async {
    final box = await Hive.openBox<bool>(adminBoxName);
    await box.put("isSaved", value);
  }
}
