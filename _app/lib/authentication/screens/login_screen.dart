import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import 'enter_phone_screen.dart';
import 'package:_app/home/home_page/home_section/screens/home_screen.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = LoginController();

  Future<void> handleLogin() async {
    final user = await controller.login(context);

    setState(() {});

    if (user != null) {
      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
    }
  }

  Widget buildInputField({
    required String label,
    required TextEditingController textController,
    required IconData icon,
    String? errorText,
    bool isPassword = false,
    required VoidCallback removeErrorIfNotEmpty,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF1C1F26), Color(0xFF222631)],
            ),
          ),
          child: TextField(
            controller: textController,
            obscureText: isPassword,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) => removeErrorIfNotEmpty(),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white54),
              border: InputBorder.none,
              errorText: errorText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              /// TITLE
              const Text(
                "Login your\naccount",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Please enter your details to continue.",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 40),

              /// EMAIL
              buildInputField(
                label: "EMAIL ADDRESS",
                textController: controller.emailController,
                icon: Icons.email_outlined,
                errorText: controller.emailError,
                removeErrorIfNotEmpty: () {
                  setState(() {
                    controller.emailError = null;
                  });
                },
              ),

              /// PASSWORD
              buildInputField(
                label: "PASSWORD",
                textController: controller.passwordController,
                icon: Icons.lock_outline,
                errorText: controller.passwordError,
                isPassword: true,
                removeErrorIfNotEmpty: () {
                  setState(() {
                    controller.passwordError = null;
                  });
                },
              ),

              /// REMEMBER + FORGOT
              Row(
                children: [
                  Checkbox(
                    value: controller.rememberMe,
                    activeColor: const Color(0xFF7B2FF7),
                    onChanged: (val) {
                      setState(() => controller.toggleRemember(val ?? true));
                    },
                  ),
                  const Text(
                    "Remember me",
                    style: TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Color(0xFF9A4DFF),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              /// LOGIN BUTTON
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B2FF7), Color(0xFF9A4DFF)],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              /// OR CONTINUE WITH
              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "OR CONTINUE WITH",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),

              const SizedBox(height: 25),

              /// SOCIAL BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// GOOGLE
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUpScreen(
                            gender: '',
                            height: '',
                            weight: '',
                            age: '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F26),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/project1/onboarding/google.jpg",
                          height: 30,
                        ),
                      ),
                    ),
                  ),

                  /// PHONE
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const EnterPhoneScreen()),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1F26),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.phone_android,
                          size: 30,
                          color: Color(0xFF7B2FF7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// SIGN UP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUpScreen(
                            gender: '',
                            height: '',
                            weight: '',
                            age: '',
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color(0xFF9A4DFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
