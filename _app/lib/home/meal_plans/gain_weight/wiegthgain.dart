import 'package:_app/home/meal_plans/gain_weight/admin_added/screens/admin_gain_category_screen.dart';
import 'package:_app/home/meal_plans/gain_weight/breakfast/screens/breakfast_gain_screen.dart';
import 'package:_app/home/meal_plans/gain_weight/lunch/screens/lunch_gain_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:_app/models/meal_model.dart';
import 'dinner/screens/dinner_gain_screen.dart';

class WeightGainPage extends StatefulWidget {
  const WeightGainPage({super.key});

  @override
  State<WeightGainPage> createState() => _WeightGainPageState();
}

class _WeightGainPageState extends State<WeightGainPage>
    with SingleTickerProviderStateMixin {
  late Box<MealCategory> mealBox;

  final List<IconData> icons = [
    Icons.restaurant,
    Icons.egg,
    Icons.coffee,
    Icons.ramen_dining,
    Icons.local_drink,
  ];

  @override
  void initState() {
    super.initState();
    mealBox = Hive.box<MealCategory>('meal_categories');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Weight Gain Meals",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: mealBox.listenable(),
        builder: (context, Box<MealCategory> box, _) {
          final adminCategories = box.values.toList();

          final List<Widget> mealCards = [
            _buildMealCard(
              icon: Icons.wb_sunny_outlined,
              title: "Breakfast",
              description:
                  "Energize your morning with a balanced start, packed with essential nutrients to kickstart your day.",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const BreakfastGainScreen()));
              },
            ),
            const SizedBox(height: 20),
            _buildMealCard(
              icon: Icons.restaurant_outlined,
              title: "Lunch",
              description:
                  "Fuel your afternoon with wholesome and delicious meals designed to sustain your energy levels.",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LunchGainScreen()));
              },
            ),
            const SizedBox(height: 20),
            _buildMealCard(
              icon: Icons.nightlight_round_outlined,
              title: "Dinner",
              description:
                  "Wind down with satisfying and nutritious evening dishes, perfect for muscle recovery and growth.",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const DinnerGainScreen()));
              },
            ),
          ];

          if (adminCategories.isNotEmpty) {
            for (var category in adminCategories) {
              final iconToUse =
                  (category.iconIndex >= 0 && category.iconIndex < icons.length)
                      ? icons[category.iconIndex]
                      : Icons.fastfood;

              mealCards.add(const SizedBox(height: 20));

              mealCards.add(
                _buildMealCard(
                  icon: iconToUse,
                  title: category.name,
                  description: category.description,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AdminGainCategoryMealScreen(
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  "Craft your ideal weight gain journey with these\nnutritious and satisfying meal options.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 25),
                ...mealCards,
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1E),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFF2A2A2C),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 22),
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
