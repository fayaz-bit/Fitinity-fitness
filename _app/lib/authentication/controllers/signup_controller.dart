import 'package:_app/models/usermodel.dart';
import 'package:flutter/material.dart';
import '../../database/authentication_database/sign_up_database.dart';

class SignUpController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmError;

  void clearNameError() => nameError = null;
  void clearEmailError() => emailError = null;
  void clearPasswordError() => passwordError = null;
  void clearConfirmError() => confirmError = null;

  bool validate(BuildContext context) {
    nameError = null;
    emailError = null;
    passwordError = null;
    confirmError = null;

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();

    if (name.isEmpty) nameError = "Enter name";

    if (email.isEmpty) {
      emailError = "Enter email";
    }
    // Gmail validation
    else if (!email.endsWith("@gmail.com")) {
      emailError = "Email is unvalid";
    }

    if (password.isEmpty) passwordError = "Enter password";

    if (confirmPassword.isEmpty) {
      confirmError = "Confirm password";
    } else if (password != confirmPassword) {
      confirmError = "Passwords do not match";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter the same password"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    return nameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmError == null;
  }

  Future<bool> registerUser({
    required BuildContext context,
    required String gender,
    required String height,
    required String weight,
    required String age,
  }) async {
    if (!validate(context)) return false;

    final newUser = UserModel(
      id: DateTime.now().toIso8601String(),
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      age: int.tryParse(age) ?? 0,
      height: int.tryParse(height) ?? 0,
      weight: int.tryParse(weight) ?? 0,
      phone: "",
      gender: gender,
      imagePath: '',
    );

    await SignUpDB.registerUser(newUser);
    await SignUpDB.saveSession(newUser.id);

    return true;
  }
}
