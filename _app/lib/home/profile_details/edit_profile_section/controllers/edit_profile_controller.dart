import 'package:_app/database/profilesection_database/edit_profile_database.dart';
import 'package:_app/models/usermodel.dart';
import 'package:flutter/material.dart';

class EditProfileController {
  UserModel? currentUser;

  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final gender = TextEditingController();
  final age = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();

  Future<void> loadUser(Function onUpdate) async {
    currentUser = await EditProfileDB.getCurrentUser();

    if (currentUser != null) {
      name.text = currentUser!.name;
      phone.text = currentUser!.phone;
      email.text = currentUser!.email;
      gender.text = currentUser!.gender;
      age.text = currentUser!.age.toString();
      height.text = currentUser!.height.toString();
      weight.text = currentUser!.weight.toString();

      onUpdate();
    }
  }

  Future<void> saveChanges(BuildContext context) async {
    if (currentUser == null) return;

    String phoneText = phone.text.trim();
    String emailText = email.text.trim();

    // Phone validation
    if (phoneText.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phoneText)) {
      _showMessage(context, "Enter a valid 10 digit phone number", Colors.red);
      return;
    }

    // Gmail validation
    if (!emailText.endsWith("@gmail.com")) {
      _showMessage(
          context, "Email must be a valid @gmail.com address", Colors.red);
      return;
    }

    currentUser!
      ..name = name.text
      ..phone = phoneText
      ..email = emailText
      ..gender = gender.text
      ..age = int.tryParse(age.text) ?? currentUser!.age
      ..height = int.tryParse(height.text) ?? currentUser!.height
      ..weight = int.tryParse(weight.text) ?? currentUser!.weight;

    await EditProfileDB.saveUser(currentUser!);

    _showMessage(context, "Profile updated successfully", Colors.green);

    Navigator.pop(context, true);
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
