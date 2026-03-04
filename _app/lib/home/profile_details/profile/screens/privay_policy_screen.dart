import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  LinearGradient get violetGradient => const LinearGradient(
        colors: [
          Color(0xFF7B2FF7),
          Color(0xFF9A4DFF),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF111217),
              Color(0xFF0B0B0B),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              /// TOP BAR
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      /// 🔙 Back Button (WORKING)
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFF1C1C1E),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      const Icon(
                        Icons.bolt,
                        color: Colors.white70,
                      ),

                      const Spacer(),

                      /// Legal Version Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF9A4DFF),
                          ),
                        ),
                        child: const Text(
                          "Legal v2.4",
                          style: TextStyle(
                            color: Color(0xFF9A4DFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(color: Colors.white12),

              /// BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      /// TITLE
                      const Text(
                        "Disclaimer &",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Terms of Service",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9A4DFF),
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Please read these documents carefully before using the Pulse Fitness Platform.",
                        style: TextStyle(
                          color: Colors.white60,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF9A4DFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// MEDICAL DISCLAIMER TITLE
                      const Row(
                        children: [
                          Icon(Icons.info_outline, color: Color(0xFF9A4DFF)),
                          SizedBox(width: 8),
                          Text(
                            "MEDICAL DISCLAIMER",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// MEDICAL CARD
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF1B1033),
                              Color(0xFF12091F),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.redAccent),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.warning_amber,
                                      color: Colors.redAccent, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    "CRITICAL HEALTH NOTICE",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 18),
                            _bullet(
                                "The app does not provide medical advice. All content is for informational purposes only."),
                            _bullet(
                                "Users should consult a doctor before starting any fitness program or changing diet."),
                            _bullet(
                                "The app is not responsible for injuries or health complications resulting from activities."),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// TERMS TITLE
                      const Row(
                        children: [
                          Icon(Icons.verified, color: Color(0xFF9A4DFF)),
                          SizedBox(width: 8),
                          Text(
                            "TERMS & CONDITIONS",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 16),

                      _termsCard(),

                      const SizedBox(height: 30),

                      const Divider(color: Colors.white24),

                      const SizedBox(height: 10),

                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "DOC ID: PF-8821",
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: violetGradient,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text(
                            "Accept & Continue",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      const Text(
                        "By tapping 'Accept', you confirm you have read and agree to be bound by the Pulse Fitness Terms of Service.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// BULLET TEXT
  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, size: 18, color: Color(0xFF9A4DFF)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// TERMS CARD
  Widget _termsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          _termItem(
            icon: Icons.person,
            title: "User Responsibilities",
            subtitle:
                "You are responsible for maintaining account security and ensuring profile data is accurate.",
          ),
          const Divider(color: Colors.white12),
          _termItem(
            icon: Icons.gavel,
            title: "Limitations of Liability",
            subtitle:
                "fitinity Fitness is not liable for indirect or incidental damages from use of the app.",
          ),
          const Divider(color: Colors.white12),
          _termItem(
            icon: Icons.credit_card,
            title: "Subscription & Payments",
            subtitle: "Membership are free always ",
          ),
          const Divider(color: Colors.white12),
          _termItem(
            icon: Icons.copyright,
            title: "Intellectual Property",
            subtitle:
                "All workouts, logos, and algorithms are exclusive property of Fitinity Fitness.",
          ),
        ],
      ),
    );
  }

  Widget _termItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF9A4DFF), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white60, height: 1.5),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
