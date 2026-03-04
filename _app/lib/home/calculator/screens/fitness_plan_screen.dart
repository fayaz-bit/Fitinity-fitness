import 'package:_app/home/calculator/controllers/bmi_controller.dart';
import 'package:flutter/material.dart';
import 'fitness_plan_service.dart';

class FitnessPlanScreen extends StatelessWidget {
  final bool? isWeightLoss;

  const FitnessPlanScreen({
    super.key,
    required this.isWeightLoss,
    required BmiCategory category,
  });

  String get category {
    if (isWeightLoss == true) return "loss";
    if (isWeightLoss == false) return "gain";
    return "maintain";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FitnessPlanService.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = FitnessPlanService.getPlan(category);

        return Scaffold(
          backgroundColor: const Color(0xFF0B0B0B),
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Text(
              "Your Fitness Plan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _sectionCard(
                    title: "Workouts",
                    icon: Icons.fitness_center,
                    accent: Colors.greenAccent,
                    items: data["workouts"],
                    showSubtitle: true,
                    type: _CardType.workout,
                    imagePath: "assets/project1/fitnesslevel/bmiworkouts.jpg",
                  ),
                  _sectionCard(
                    title: "Nutrition",
                    icon: Icons.restaurant,
                    accent: Colors.orangeAccent,
                    items: data["foods"],
                    type: _CardType.food,
                    imagePath: "assets/project1/fitnesslevel/bminutritions.jpg",
                  ),
                  _sectionCard(
                    title: "Tips",
                    icon: Icons.lightbulb,
                    accent: Colors.blueAccent,
                    items: (data["tips"] as List)
                        .map((e) => {"title": e})
                        .toList(),
                    type: _CardType.tip,
                    imagePath: "assets/project1/fitnesslevel/bmitips.jpg",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // =======================
  // SECTION CARD
  // =======================
  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Color accent,
    required List items,
    required _CardType type,
    required String imagePath,
    bool showSubtitle = false,
  }) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              Icon(icon, color: accent),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // LIST
          Expanded(
            flex: 3,
            child: ListView(
              children: items.map<Widget>((e) {
                return _itemCard(
                  data: e,
                  type: type,
                  accent: accent,
                  showSubtitle: showSubtitle,
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // 🔥 BIG IMAGE (FILLS FREE SPACE)
          Expanded(
            flex: 2,
            child: _bigImage(imagePath),
          ),
        ],
      ),
    );
  }

  // =======================
  // ITEM CARD
  // =======================
  Widget _itemCard({
    required Map<String, dynamic> data,
    required _CardType type,
    required Color accent,
    bool showSubtitle = false,
  }) {
    final title = data["title"];
    final subtitle = data["duration"] ?? data["sets"] ?? "";

    IconData icon;
    switch (type) {
      case _CardType.workout:
        icon = Icons.flash_on;
        break;
      case _CardType.food:
        icon = Icons.local_dining;
        break;
      case _CardType.tip:
        icon = Icons.check_circle;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (showSubtitle && subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =======================
  // BIG IMAGE WIDGET
  // =======================
  Widget _bigImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

enum _CardType { workout, food, tip }
