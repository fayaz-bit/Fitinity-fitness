import 'package:hive/hive.dart';
import '../../models/usermodel.dart';

class EditProfileDB {
  // Get current user
  static Future<UserModel?> getCurrentUser() async {
    var sessionBox = await Hive.openBox('session');
    var userBox = await Hive.openBox<UserModel>('users');

    String? currentUserId = sessionBox.get('currentUserId');
    if (currentUserId == null) return null;

    return userBox.get(currentUserId);
  }

  // Save updated user info
  static Future<void> saveUser(UserModel user) async {
    await user.save();
  }
}
