import 'package:flutter/material.dart';
import 'package:_app/home/home_page/home_section/screens/home_screen.dart';
import 'sign_up_screen.dart';
import '../controllers/phone_login_controller.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({super.key});

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  final PhoneLoginController controller = PhoneLoginController();

  Future<void> handleLogin() async {
    final user = await controller.loginWithPhone(context);
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

  Widget buildField({
    required TextEditingController textController,
    required IconData icon,
    required String hint,
    String? errorText,
    bool isPassword = false,
    required VoidCallback onTyping,
  }) {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF111827), Color(0xFF1F2937)],
            ),
          ),
          child: TextField(
            controller: textController,
            obscureText: isPassword,
            onChanged: (_) => onTyping(),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white54),
              suffixIcon: isPassword
                  ? const Icon(Icons.visibility_off, color: Colors.white38)
                  : null,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white38),
              border: InputBorder.none,
              errorText: errorText,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Purple background glow
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  /// Top Icon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bolt,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Title
                  const Text(
                    "Login with",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Phone",
                    style: TextStyle(
                      color: Color(0xFF9A4DFF),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Welcome back! Please enter your credentials to access your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  buildField(
                    textController: controller.phoneController,
                    icon: Icons.phone_iphone,
                    hint: "000-000-0000",
                    errorText: controller.phoneError,
                    onTyping: () =>
                        setState(() => controller.clearPhoneError()),
                  ),

                  buildField(
                    textController: controller.passwordController,
                    icon: Icons.lock_outline,
                    hint: "••••••••",
                    errorText: controller.passwordError,
                    isPassword: true,
                    onTyping: () =>
                        setState(() => controller.clearPasswordError()),
                  ),

                  /// Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Login Button
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.white),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Sign up
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
                              builder: (_) => const SignUpScreen(
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

                  const SizedBox(height: 40),

                  /// Security Pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF111827),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.security,
                            size: 16, color: Color(0xFF9A4DFF)),
                        SizedBox(width: 8),
                        Text(
                          "SECURED",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "ENCRYPTION",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Bottom indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 3,
                        color: Colors.white24,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 3,
                        color: const Color(0xFF9A4DFF),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 3,
                        color: Colors.white24,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
