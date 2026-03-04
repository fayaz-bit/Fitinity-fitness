import 'package:flutter/material.dart';

import 'warmup_cobra_detail.dart';
import 'warmup_forward_fold_detail.dart';
import 'warmup_seated_side_detail.dart';
import 'warmup_cross_arm_detail.dart';

class WarmUpGuideScreen extends StatelessWidget {
  const WarmUpGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "WARM-UP GUIDE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          _warmUpCard(
            context,
            image: "assets/project1/fitnesslevel/warmup1.jpg",
            title: "COBRA STRETCH",
            page: const WarmUpCobraDetailScreen(),
          ),
          _warmUpCard(
            context,
            image: "assets/project1/fitnesslevel/warmup2.jpg",
            title: "FORWARD FOLD",
            page: const WarmUpForwardFoldDetail(),
          ),
          _warmUpCard(
            context,
            image: "assets/project1/fitnesslevel/warmup3.jpg",
            title: "SEATED SIDE STRETCH",
            page: const WarmUpSeatedSideDetail(),
          ),
          _warmUpCard(
            context,
            image: "assets/project1/fitnesslevel/warmup4.jpg",
            title: "CROSS-BODY ARM STRETCH",
            page: const WarmUpCrossArmDetail(),
          ),
        ],
      ),
    );
  }

  Widget _warmUpCard(
    BuildContext context, {
    required String image,
    required String title,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              /// Image
              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),

              ///  Transparent Black Strip
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
