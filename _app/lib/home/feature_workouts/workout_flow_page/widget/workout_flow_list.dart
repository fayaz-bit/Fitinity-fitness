import 'dart:io';
import 'package:flutter/material.dart';
import '../../warmup/warm_up.dart';
import '../../chest_workout/screens/chest_workout.dart';
import '../../shoulder_workout/screens/shoulder_workout_screen.dart';
import '../../leg_workout/screens/leg_workout_screen.dart';
import '../../arms_workout/screens/arms_workout_screen.dart';
import '../../back_workout/screens/back_workout_screen.dart';
import '../../admin_added_workout/screens/admin_added_workout_screen.dart';
import '../controllers/workout_flow_controller.dart';

class WorkoutFlowList extends StatelessWidget {
  final WorkoutFlowController controller;

  const WorkoutFlowList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Workout Flow',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.info_outline, color: Colors.white),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.white12,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// WARMUP CARD
            _warmUpCard(context),

            const SizedBox(height: 24),

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SELECT FOCUS AREA",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "${controller.exercises.length} TARGETS",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  ..._buildFixedWorkouts(context),
                  _buildAdminCategories(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 Warmup Card
  Widget _warmUpCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1C1F26), Color(0xFF20242D)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// top badges
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C2BD9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Mandatory Step",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                " STAY SAFE",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),

          const SizedBox(height: 14),

          const Text(
            "ALWAYS WARM UP FIRST",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Ensure your muscles are ready for action with a guided warm-up routine. Proper warm-up prevents injuries and maximizes performance.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 18),

          /// Gradient Button
          Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF7B2FF7), Color(0xFF9A4DFF)],
              ),
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const WarmUpGuideScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                "Start Warm-up",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildFixedWorkouts(BuildContext context) {
    return controller.exercises.map((exercise) {
      Widget page;

      switch (exercise["name"]) {
        case "Chest":
          page = const ChestWorkoutScreen();
          break;
        case "Shoulder":
          page = const ShoulderWorkoutScreen();
          break;
        case "Leg":
          page = const LegWorkoutScreen();
          break;
        case "Arms":
          page = const ArmsWorkoutScreen();
          break;
        case "Back":
          page = const BackWorkoutScreen();
          break;
        default:
          page = const Scaffold();
      }

      return _buildImageTile(
        context,
        title: exercise["name"]!,
        imagePath: exercise["image"]!,
        page: page,
      );
    }).toList();
  }

  Widget _buildAdminCategories(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.listenable(),
      builder: (context, box, _) {
        if (box.isEmpty) return const SizedBox.shrink();

        return Column(
          children: List.generate(box.length, (i) {
            final category = box.getAt(i)!;

            return _buildImageTile(
              context,
              title: category.name,
              imagePath: category.imagePath,
              page: CategoryWorkoutScreen(categoryName: category.name),
              isFile: true,
            );
          }),
        );
      },
    );
  }

  Widget _buildImageTile(
    BuildContext context, {
    required String title,
    required String imagePath,
    required Widget page,
    bool isFile = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: isFile
                  ? Image.file(
                      File(imagePath),
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),

            /// dark overlay
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.35),
              ),
            ),

            /// left pill
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            /// right arrow
            const Positioned(
              right: 18,
              top: 65,
              child: Icon(Icons.chevron_right, color: Colors.white70, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
