import 'package:_app/admin/meals/controllers/categorize_meals_controller.dart';
import 'package:_app/admin/meals/widget/categorize_meals_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:_app/models/meal_model.dart';

class CategorizeMealsPage extends StatefulWidget {
  const CategorizeMealsPage({super.key});

  @override
  State<CategorizeMealsPage> createState() => _CategorizeMealsPageState();
}

class _CategorizeMealsPageState extends State<CategorizeMealsPage> {
  final controller = CategorizeMealsController();

  static const Color primaryViolet = Color(0xFF9A4DFF);

  @override
  void initState() {
    super.initState();
    controller.openBox(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (controller.boxFuture == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: primaryViolet)),
      );
    }

    return FutureBuilder(
      future: controller.boxFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body:
                Center(child: CircularProgressIndicator(color: primaryViolet)),
          );
        }

        final box = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            foregroundColor: Colors.white,
            title: const Text(
              "Categorize Meals",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildLabel("Category Name"),
                buildInputField(controller.nameController, "e.g., Breakfast"),
                const SizedBox(height: 18),
                buildLabel("Description"),
                buildInputField(
                  controller.descController,
                  "Briefly describe this category",
                  maxLines: 2,
                ),
                const SizedBox(height: 18),
                buildLabel("Category Icon"),
                const SizedBox(height: 10),
                buildIconsRow(
                  icons: controller.icons,
                  selectedIndex: controller.selectedIconIndex,
                  onSelect: (index) {
                    setState(() {
                      controller.selectedIconIndex = index;
                    });
                  },
                ),
                const SizedBox(height: 18),
                const Text(
                  "Existing Categories",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: box.listenable(),
                    builder: (context, Box<MealCategory> categories, _) {
                      if (categories.isEmpty) {
                        return const Center(
                          child: Text(
                            "No categories yet",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories.getAt(index)!;

                          return Card(
                            color: const Color(0xff232127),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: primaryViolet,
                                child: Icon(
                                  controller.icons[category.iconIndex],
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                category.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                category.description,
                                style: const TextStyle(color: Colors.white54),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () => controller.deleteCategory(
                                  context,
                                  index,
                                  () => setState(() {}),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () => controller.saveCategory(
                    context,
                    () => setState(() {}),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryViolet,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Add Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
