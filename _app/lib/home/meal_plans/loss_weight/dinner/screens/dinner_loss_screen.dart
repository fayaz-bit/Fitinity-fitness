import 'package:_app/database/mealplans_database/weight_loss_database.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/add_meal.dart';
import 'package:_app/home/meal_plans/add_edit_section/screens/edit_meal.dart';
import 'package:_app/widget/meal/meal_card.dart';
import 'package:_app/widget/dialogue/confirm_delete_dialogue.dart';
import 'package:flutter/material.dart';

class DinnerPage extends StatefulWidget {
  const DinnerPage({super.key});

  @override
  State<DinnerPage> createState() => _DinnerPageState();
}

class _DinnerPageState extends State<DinnerPage> {
  final DinnerWeightLossDatabase db = DinnerWeightLossDatabase();
  List<Map<String, String>> meals = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    await db.initDB(); // ✔ FIXED
    setState(() {
      meals = db.getAllMeals();
      loading = false;
    });
  }

  Future<void> addMeal(Map<String, String> meal) async {
    await db.addMeal(meal);
    setState(() => meals.add(meal));
  }

  Future<void> updateMeal(int index, Map<String, String> meal) async {
    await db.updateMeal(index, meal);
    setState(() => meals[index] = meal);
  }

  Future<void> deleteMeal(int index) async {
    await db.deleteMeal(index);
    setState(() => meals.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Dinner",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.purpleAccent),
            )
          : meals.isEmpty
              ? const Center(
                  child: Text(
                    "No meals added yet",
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: meals.length,
                  itemBuilder: (_, i) {
                    final meal = meals[i];
                    return MealCard(
                      meal: meal,
                      index: i,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit,
                                color: Colors.purpleAccent),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditMealPage(meal: meal, index: i),
                                ),
                              );
                              if (result != null &&
                                  result is Map<String, String>) {
                                await updateMeal(i, result);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.redAccent),
                            onPressed: () => showConfirmDeleteDialog(
                              context,
                              onConfirm: () async => await deleteMeal(i),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8416BC),
        onPressed: () async {
          final r = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NewMealPage()),
          );
          if (r != null && r is Map<String, String>) {
            await addMeal(r);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
