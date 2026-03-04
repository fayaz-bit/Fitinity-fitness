import 'package:_app/admin/workout/controllers/add_video_fields_controller.dart';
import 'package:flutter/material.dart';

class AddVideosPage extends StatefulWidget {
  const AddVideosPage({super.key});

  @override
  State<AddVideosPage> createState() => _AddVideosPageState();
}

class _AddVideosPageState extends State<AddVideosPage> {
  final AddVideosController controller = AddVideosController();

  @override
  void initState() {
    super.initState();
    controller.loadStatus(() => setState(() {}));
  }

  // Disabled Field UI
  Widget _disabledField(String hint) {
    return TextField(
      enabled: false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF1C1C1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Upload Box
  Widget _uploadBox() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.video_call, color: Colors.white54, size: 50),
            SizedBox(height: 10),
            Text("Drag or click to upload video",
                style: TextStyle(color: Colors.white54)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF9A4DFF);

    if (controller.loading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    final bool saveEnabled =
        controller.fieldsSelected && !controller.savedStatus;
    final bool deleteEnabled = controller.savedStatus;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text("Add Video Fields"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () {
            if (!controller.savedStatus) {
              setState(() => controller.fieldsSelected = true);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: controller.fieldsSelected ? purple : Colors.white24,
                width: controller.fieldsSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // ⭐ FIX — Shrinks container
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Video Title",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 10),
                _disabledField("Enter video title"),
                const SizedBox(height: 10),
                const Text("Video URL (Optional)",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 10),
                _disabledField("Paste YouTube or Vimeo URL"),
                const SizedBox(height: 10),
                const Text("Upload Video File",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                _uploadBox(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: saveEnabled
                  ? () async {
                      await controller.saveFields(context);
                      setState(() {});
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: saveEnabled ? purple : Colors.grey,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Save Fields"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: deleteEnabled
                  ? () async {
                      await controller.deleteFields(context);
                      setState(() {});
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: deleteEnabled ? Colors.red : Colors.grey,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Delete Field"),
            ),
          ],
        ),
      ),
    );
  }
}
