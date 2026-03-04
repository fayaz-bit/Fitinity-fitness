import 'package:_app/authentication/screens/login_screen.dart';
import 'package:_app/database/profilesection_database/profile_database.dart';
import 'package:_app/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController {
  UserModel? currentUser;
  final ImagePicker picker = ImagePicker();
  int selectedIndex = 2;

  Future<void> loadUser(Function onUpdate) async {
    currentUser = await ProfileDB.getCurrentUser();

    if (currentUser != null) {
      ProfileDB.watchCurrentUser(currentUser!.id).listen((updatedUser) {
        currentUser = updatedUser;
        onUpdate();
      });
    }

    onUpdate();
  }

  Future<void> pickImage(Function onUpdate) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null && currentUser != null) {
      await ProfileDB.updateProfileImage(currentUser!, picked.path);
      onUpdate();
    }
  }

  void onNavTap(BuildContext context, int index, Function onUpdate,
      Widget timerPage, Widget homePage) {
    selectedIndex = index;
    onUpdate();

    if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => homePage));
    } else if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => timerPage));
    }
  }

  Future<void> logout(BuildContext context) async {
    await ProfileDB.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}
