import 'package:flutter/material.dart';
import '../controllers/signup_controller.dart';
import 'login_screen.dart';
import 'package:_app/home/home_page/home_section/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  final String gender;
  final String height;
  final String weight;
  final String age;

  const SignUpScreen({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController controller = SignUpController();

  Future<void> handleSignup() async {
    bool success = await controller.registerUser(
      context: context,
      gender: widget.gender,
      height: widget.height,
      weight: widget.weight,
      age: widget.age,
    );

    setState(() {});

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
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
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              errorText: errorText,
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
          /// Purple Glow Background
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Back Arrow
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(height: 20),

                  /// Title
                  const Text(
                    "Create your\naccount",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Join us today and start your journey with a premium experience.",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  buildField(
                    textController: controller.nameController,
                    icon: Icons.person_outline,
                    hint: "Full Name",
                    errorText: controller.nameError,
                    onTyping: () => setState(controller.clearNameError),
                  ),

                  buildField(
                    textController: controller.emailController,
                    icon: Icons.email_outlined,
                    hint: "Email Address",
                    errorText: controller.emailError,
                    onTyping: () => setState(controller.clearEmailError),
                  ),

                  buildField(
                    textController: controller.passwordController,
                    icon: Icons.lock_outline,
                    hint: "Password",
                    errorText: controller.passwordError,
                    isPassword: true,
                    onTyping: () => setState(controller.clearPasswordError),
                  ),

                  buildField(
                    textController: controller.confirmController,
                    icon: Icons.verified_user_outlined,
                    hint: "Confirm Password",
                    errorText: controller.confirmError,
                    isPassword: true,
                    onTyping: () => setState(controller.clearConfirmError),
                  ),

                  const SizedBox(height: 20),

                  /// Sign Up Button
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
                      onPressed: handleSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF9A4DFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// GET IN Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white24)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "GET IN",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white24)),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "By signing up, you agree to our Terms of Service and Privacy Policy. We handle your data with enterprise-grade security.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
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
