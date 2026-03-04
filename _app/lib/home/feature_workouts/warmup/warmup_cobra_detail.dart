import 'package:flutter/material.dart';

class WarmUpCobraDetailScreen extends StatelessWidget {
  const WarmUpCobraDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0F13),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Cobra Stretch",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= IMAGE WITH PLAY =================
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                "assets/project1/fitnesslevel/warmup1.jpg",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // ================= INSTRUCTIONS =================
            _sectionTitle("Instructions"),

            const SizedBox(height: 12),

            _instructionStep(
              number: "1",
              text:
                  "Lie face down on your mat with your palms placed under your shoulders, fingers pointing forward.",
            ),
            _instructionStep(
              number: "2",
              text:
                  "Engage your core and gently press up to arch your back, keeping your hips on the floor.",
            ),
            _instructionStep(
              number: "3",
              text:
                  "Keep your shoulders relaxed and away from your ears, looking slightly upwards.",
            ),

            const SizedBox(height: 10),

            const Text(
              "Hold for 10–15 seconds. Repeat 2–3 times.",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            // ================= INFO ROW =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _InfoItem(
                  icon: Icons.timer,
                  title: "15s hold",
                  subtitle: "Duration",
                ),
                _InfoItem(
                  icon: Icons.flash_on,
                  title: "Beginner",
                  subtitle: "Difficulty",
                ),
                _InfoItem(
                  icon: Icons.adjust,
                  title: "Back/Core",
                  subtitle: "Focus",
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ================= MUSCLES =================
            _sectionTitle("Muscles Targeted"),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _MuscleChip("Erector Spinae"),
                _MuscleChip("Abdominals (stretched)"),
                _MuscleChip("Glutes"),
                _MuscleChip("Shoulders"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= SECTION TITLE =================
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ================= INSTRUCTION STEP =================
  Widget _instructionStep({
    required String number,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= INFO ITEM =================
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.deepPurple, size: 22),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

// ================= MUSCLE CHIP =================
class _MuscleChip extends StatelessWidget {
  final String text;

  const _MuscleChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF15161C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
    );
  }
}
