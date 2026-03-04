import 'dart:io';
import 'package:_app/home/profile_details/profile/screens/privay_policy_screen.dart';
import 'package:_app/home/profile_details/profile/widget/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:_app/admin/main/admin_login.dart';
import 'package:_app/home/home_page/home_section/screens/home_screen.dart';
import 'package:_app/home/home_page/timer_section/screens/timer_screen.dart';
import 'package:_app/home/profile_details/edit_profile_section/screens/edit_profile_screen.dart';
import 'package:_app/home/profile_details/profile/controllers/profile_controller.dart';
import 'package:_app/home/profile_details/profile/widget/logout_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = ProfileController();
    controller.loadUser(() => setState(() {}));
  }

  String _safeString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Not added";
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.currentUser;

    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF8416BC)),
        ),
      );
    }

    const purple = Color(0xFF8416BC);

    return Scaffold(
      backgroundColor: Colors.black,

      //  APP BAR
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "PROFILE",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shield_outlined, color: purple),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminLoginScreen(),
                ),
              );
            },
          )
        ],
      ),

      //  BODY
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),

            //  Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  // ignore: unnecessary_null_comparison
                  backgroundImage: user.imagePath != null
                      ? FileImage(File(user.imagePath))
                      : null,
                  backgroundColor: Colors.grey[800],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => controller.pickImage(() => setState(() {})),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: purple,
                      ),
                      child: const Icon(Icons.camera_alt,
                          size: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 15),

            Text(
              _safeString(user.name),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              _safeString(user.email),
              style: const TextStyle(
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 25),

            //  DETAILS CARD
            ProfileDetailsCard(
              user: user,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
              onLogout: () {
                showLogoutDialog(
                  context,
                  () => controller.logout(context),
                );
              },
              onPrivacy: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DisclaimerScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      //  BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        backgroundColor: Colors.black,
        selectedItemColor: purple,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const TimerScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.timer_outlined), label: "Timer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
