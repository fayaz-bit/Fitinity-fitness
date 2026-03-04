// lib/db/login_db.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/usermodel.dart';

class LoginDB {
  // Email login
  static Future<UserModel?> loginWithEmail(
      String email, String password) async {
    var userBox = await Hive.openBox<UserModel>('users');
    final users = userBox.values.toList();

    final user = users.firstWhere(
      (u) => u.email == email && (u.password ?? '') == password,
      orElse: () => UserModel(
        id: '',
        name: '',
        email: '',
        age: 0,
        height: 0,
        weight: 0,
        gender: '',
        phone: '',
        imagePath: '',
      ),
    );

    if (user.id.isEmpty) return null;

    var sessionBox = await Hive.openBox('session');
    await sessionBox.put('currentUserId', user.id);

    return user;
  }
}
