import 'package:flutter/material.dart';
import '../../database/authentication_database/login_database.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;
  bool rememberMe = true;

  Future<dynamic> login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    emailError = null;
    passwordError = null;

    // Validate empty fields
    if (email.isEmpty || password.isEmpty) {
      if (email.isEmpty) emailError = "Enter your email";
      if (password.isEmpty) passwordError = "Enter your password";
      return null;
    }

    // Gmail validation
    if (!email.endsWith("@gmail.com")) {
      emailError = "Email is unvalid";
      return null;
    }

    final user = await LoginDB.loginWithEmail(email, password);

    if (user == null) {
      _showMessage(
        context,
        "User not registered or incorrect password.",
        Colors.red,
      );
      return null;
    }

    _showMessage(
      context,
      "Welcome back, ${user.name}!",
      Colors.green,
    );

    return user;
  }

  void toggleRemember(bool value) {
    rememberMe = value;
  }

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
