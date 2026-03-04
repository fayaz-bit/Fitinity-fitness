import 'package:hive/hive.dart';
import '../../models/usermodel.dart';

class EditProfileDB {
  static const String userBoxName = "userBox";

  /// Get current user (assuming first user for simplicity)
  static Future<UserModel?> getCurrentUser() async {
    final box = await Hive.openBox<UserModel>(userBoxName);
    if (box.isNotEmpty) {
      return box.getAt(0);
    }
    return null;
  }

  /// Save user changes
  static Future<void> saveUser(UserModel user) async {
    final box = await Hive.openBox<UserModel>(userBoxName);
    if (box.isEmpty) {
      await box.add(user);
    } else {
      await box.putAt(0, user);
    }
  }
}
