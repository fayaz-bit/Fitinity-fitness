import 'package:flutter/material.dart';
import 'gain_weight/wiegthgain.dart';
import 'loss_weight/wieghtloss.dart';
import 'maintain_weight/maintain.dart';

class MealLevelsScreen extends StatelessWidget {
  const MealLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('Meal levels'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover Your Path',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select a plan that aligns with your fitness goals and start your journey to a healthier you.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildMealCard(
                    context,
                    image: const AssetImage(
                        'assets/project1/fitnesslevel/wieghtgain.jpg'),
                    title: 'Weight gain',
                    height: screenHeight * 0.3,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WeightGainPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMealCard(
                    context,
                    image: const AssetImage(
                        'assets/project1/fitnesslevel/weightloss.jpg'),
                    title: 'Weight loss',
                    height: screenHeight * 0.3,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WeightLossPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMealCard(
                    context,
                    image: const AssetImage(
                        'assets/project1/fitnesslevel/maintainweight.jpg'),
                    title: 'Maintain weight',
                    height: screenHeight * 0.3,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MaintainWeightPage()),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(BuildContext context,
      {required String title,
      required VoidCallback onTap,
      required AssetImage image,
      required double height}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image(
              image: image,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MealLevelsScreen(),
  ));
}
