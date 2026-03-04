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

    currentUser!
      ..name = name.text
      ..phone = phone.text
      ..email = email.text
      ..gender = gender.text
      ..age = int.tryParse(age.text) ?? currentUser!.age
      ..height = int.tryParse(height.text) ?? currentUser!.height
      ..weight = int.tryParse(weight.text) ?? currentUser!.weight;

    await EditProfileDB.saveUser(currentUser!);
    Navigator.pop(context, true);
  }
}
