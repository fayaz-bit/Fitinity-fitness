import 'package:_app/home/calculator/screens/fitness_plan_screen.dart';
import 'package:flutter/material.dart';
import '../controllers/bmi_controller.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final BmiController controller = BmiController();

  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  int selectedGoalIndex = 1;

  // =========================
  // CALCULATE BMI
  // =========================
  void calculateBMI() {
    if (heightController.text.isEmpty ||
        weightController.text.isEmpty ||
        ageController.text.isEmpty) return;

    final height = double.parse(heightController.text);
    final weight = double.parse(weightController.text);
    final age = int.parse(ageController.text);

    controller.calculateFromInputs(
      heightCm: height,
      weightKg: weight,
      age: age,
    );

    /// 🔥 AUTO SELECT GOAL BASED ON BMI
    if (controller.category == BmiCategory.underweight) {
      selectedGoalIndex = 2; // Gain
    } else if (controller.category == BmiCategory.normal) {
      selectedGoalIndex = 1; // Maintain
    } else {
      selectedGoalIndex = 0; // Loss
    }

    setState(() {});
  }

  // =========================
  // NAVIGATE TO PLAN
  // =========================
  void goToWorkout() {
    if (!controller.hasResult || controller.category == null) return;

    bool? goal;

    if (selectedGoalIndex == 0) {
      goal = true; // Weight Loss
    } else if (selectedGoalIndex == 2) {
      goal = false; // Weight Gain
    } else {
      goal = null; // Maintain
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FitnessPlanScreen(
          category: controller.category!,
          isWeightLoss: goal,
        ),
      ),
    );
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "BMI Calculator",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _inputCard(
              icon: Icons.calendar_today,
              label: "Age",
              controller: ageController,
              suffix: "Years",
            ),
            const SizedBox(height: 16),
            _inputCard(
              icon: Icons.monitor_weight,
              label: "Weight",
              controller: weightController,
              suffix: "kg",
            ),
            const SizedBox(height: 16),
            _inputCard(
              icon: Icons.height,
              label: "Height",
              controller: heightController,
              suffix: "cm",
            ),
            const SizedBox(height: 20),

            // ======================
            // CALCULATE BUTTON
            // ======================
            _gradientButton(
              text: "Calculate BMI",
              onTap: calculateBMI,
            ),

            const SizedBox(height: 20),

            // ======================
            // GOAL SELECTOR
            // ======================
            _goalSelector(),

            const SizedBox(height: 20),

            // ======================
            // RESULT CARD
            if (controller.hasResult && controller.category != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7B2FF7),
                      Color(0xFF9A4DFF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your BMI",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// 🔥 BMI VALUE
                    Text(
                      controller.bmiValue.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 🔥 CATEGORY CHIP
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.category!.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 🔥 DYNAMIC MESSAGE

                    Text(
                      (controller.bmiMessage),
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.5,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            // ======================
            // VIEW PLAN BUTTON
            // ======================
            if (controller.hasResult)
              _gradientButton(
                text: "View My Workout Plan",
                onTap: goToWorkout,
              ),
          ],
        ),
      ),
    );
  }

  // =========================
  // GOAL SELECTOR WIDGET
  // =========================
  Widget _goalSelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: List.generate(3, (index) {
          final titles = ["Weight Loss", "Maintain", "Weight Gain"];
          final selected = selectedGoalIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedGoalIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: selected
                      ? const LinearGradient(
                          colors: [
                            Color(0xFF7B2FF7),
                            Color(0xFF9A4DFF),
                          ],
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    titles[index],
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // =========================
  // INPUT CARD
  // =========================
  Widget _inputCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String suffix,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14), // 👈 balanced
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9A4DFF), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
            ),
          ),
          Text(
            suffix,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  // =========================
  // GRADIENT BUTTON
  // =========================
  Widget _gradientButton({
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7B2FF7),
            Color(0xFF9A4DFF),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
