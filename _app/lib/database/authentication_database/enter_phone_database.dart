// lib/db/db_functions.dart
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/usermodel.dart';

class DBFunctions {
  static Future<UserModel?> loginWithPhone(
      String phone, String password) async {
    var userBox = await Hive.openBox<UserModel>('users');
    final users = userBox.values.toList();

    final user = users.firstWhere(
      (u) => u.phone == phone && (u.password ?? '') == password,
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
