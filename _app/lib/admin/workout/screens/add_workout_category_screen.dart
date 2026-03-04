import 'dart:io';
import 'package:_app/admin/workout/controllers/add_workout_category_controller.dart';
import 'package:_app/admin/workout/widget/workout_category_widgets.dart';
import 'package:_app/database/admin_database/categorize_workout_database.dart';
import 'package:_app/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddWorkoutCategoryPage extends StatefulWidget {
  const AddWorkoutCategoryPage({super.key});

  @override
  State<AddWorkoutCategoryPage> createState() => _AddWorkoutCategoryPageState();
}

class _AddWorkoutCategoryPageState extends State<AddWorkoutCategoryPage> {
  final AddWorkoutCategoryController controller =
      AddWorkoutCategoryController();

  Future<void> _pickImg() async {
    final picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.camera);

    if (img != null) {
      controller.pickImage(File(img.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Categorize Workouts"),
      ),
      body: FutureBuilder(
        future: AdminWorkoutCategoryDB.openBox(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF9A4DFF),
              ),
            );
          }

          final box = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Category Name",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 8),
                categoryTextField(
                  controller.nameController,
                  "Eg: Biceps",
                ),
                const SizedBox(height: 20),
                const Text(
                  "Image File",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 180,
                  child: categoryImageBox(
                    pickedImage: controller.pickedImage,
                    onTap: _pickImg,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Existing Categories",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, Box<AdminWorkoutCategory> items, _) {
                    if (items.isEmpty) {
                      return const Text(
                        "No categories yet",
                        style: TextStyle(color: Colors.white54),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final cat = items.getAt(index)!;
                        final imageFile = File(cat.imagePath);

                        return Card(
                          color: const Color(0xFF1C1C1E),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: imageFile.existsSync()
                                  ? Image.file(
                                      imageFile,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        return _imagePlaceholder();
                                      },
                                    )
                                  : _imagePlaceholder(),
                            ),
                            title: Text(
                              cat.name,
                              style: const TextStyle(color: Colors.white),
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.saveCategory(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9A4DFF),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    "Save Category",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// FALLBACK IMAGE WIDGET
  Widget _imagePlaceholder() {
    return Container(
      width: 50,
      height: 50,
      color: Colors.grey.shade800,
      child: const Icon(
        Icons.broken_image,
        color: Colors.white54,
      ),
    );
  }
}
