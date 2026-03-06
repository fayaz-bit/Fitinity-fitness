import 'dart:async';
import 'package:flutter/material.dart';
import 'package:_app/models/usermodel.dart';
import 'package:_app/home/home_page/home_section/screens/home_screen.dart';
import 'First_screen.dart';
import 'package:_app/database/profilesection_database/profile_database.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    _currentUser = await ProfileDB.getCurrentUser();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => _currentUser != null
              ? const HomeScreen()
              : const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image (Your New Logo Image)
          SizedBox.expand(
            child: Image.asset(
              "assets/project1/fitnesslevel/fitnity_logo.png",
              fit: BoxFit.cover,
            ),
          ),

          /// Bottom Gradient Fade
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                  Colors.black,
                ],
              ),
            ),
          ),

          /// Bottom Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Motivational Line
                  const Text(
                    "Push Your Limits.\nUnlock Your Strength.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Your transformation starts today.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Get Started Button
                  Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7B2FF7),
                          Color(0xFF9A4DFF),
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _currentUser != null
                                ? const HomeScreen()
                                : const OnboardingScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
