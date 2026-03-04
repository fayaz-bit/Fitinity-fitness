import 'package:hive_flutter/hive_flutter.dart';
import '../../models/usermodel.dart';

class SignUpDB {
  // Save new user
  static Future<void> registerUser(UserModel newUser) async {
    var box = await Hive.openBox<UserModel>('users');
    await box.put(newUser.id, newUser);
  }

  // Save current session
  static Future<void> saveSession(String userId) async {
    var sessionBox = await Hive.openBox('session');
    await sessionBox.put('currentUserId', userId);
  }
}
