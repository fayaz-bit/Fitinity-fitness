import 'package:flutter/material.dart';
import '../../database/authentication_database/enter_phone_database.dart';

class PhoneLoginController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String? phoneError;
  String? passwordError;
  bool validate() {
    phoneError = null;
    passwordError = null;

    String phone = phoneController.text.trim();

    if (phone.isEmpty) {
      phoneError = "Enter phone number";
    } else if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      phoneError = "Enter a valid 10 digit phone number";
    }

    if (passwordController.text.trim().isEmpty) {
      passwordError = "Enter password";
    }

    return phoneError == null && passwordError == null;
  }

  Future<dynamic> loginWithPhone(BuildContext context) async {
    if (!validate()) return null;

    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    final user = await DBFunctions.loginWithPhone(phone, password);

    if (user == null) {
      _showMessage(
        context,
        "Phone number not registered or incorrect password",
        Colors.red,
      );
      return null;
    }

    _showMessage(context, "Welcome back, ${user.name}!", Colors.green);
    return user;
  }

  void clearPhoneError() => phoneError = null;
  void clearPasswordError() => passwordError = null;

  void _showMessage(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
