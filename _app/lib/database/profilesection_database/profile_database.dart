import 'package:hive_flutter/hive_flutter.dart';
import '../../models/usermodel.dart';

class ProfileDB {
  static Future<UserModel?> getCurrentUser() async {
    var sessionBox = await Hive.openBox('session');
    var userBox = await Hive.openBox<UserModel>('users');

    String? userId = sessionBox.get('currentUserId');
    if (userId == null) return null;

    return userBox.get(userId);
  }

  static Stream<UserModel?> watchCurrentUser(String userId) async* {
    var userBox = await Hive.openBox<UserModel>('users');
    yield* userBox.watch(key: userId).map((event) => event.value as UserModel?);
  }

  static Future<void> updateProfileImage(
      UserModel user, String imagePath) async {
    user.imagePath = imagePath;
    await user.save();
  }

  static Future<void> logout() async {
    var sessionBox = await Hive.openBox('session');
    await sessionBox.delete('currentUserId');
  }
}
