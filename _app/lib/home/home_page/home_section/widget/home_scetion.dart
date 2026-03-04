import 'package:flutter/material.dart';

class HomeSectionWidget extends StatelessWidget {
  final String title;
  final String img1;
  final String img2;
  final VoidCallback onSeeAll;

  const HomeSectionWidget({
    super.key,
    required this.title,
    required this.img1,
    required this.img2,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                "See All",
                style: TextStyle(
                  color: Color(0xFF8B2CF5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        /// Image Cards
        Row(
          children: [
            Expanded(child: _imageCard(img1)),
            const SizedBox(width: 15),
            Expanded(child: _imageCard(img2)),
          ],
        ),

        const SizedBox(height: 30),
      ],
    );
  }

  Widget _imageCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          /// Bottom overlay like screenshot
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black.withOpacity(0.7),
              child: const Text(
                "Explore",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
