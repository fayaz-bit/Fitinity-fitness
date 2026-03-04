import 'package:flutter/material.dart';

class WorkoutForm extends StatefulWidget {
  final dynamic controller;
  final bool isEdit;

  const WorkoutForm({
    super.key,
    required this.controller,
    required this.isEdit,
  });

  @override
  State<WorkoutForm> createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------------------- WORKOUT NAME --------------------
            const Text("Workout name",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),

            TextField(
              controller: controller.workoutNameController,
              style: const TextStyle(color: Colors.white),
              onChanged: (v) => controller.workoutName = v,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                hintText: "Enter workout name",
                hintStyle: const TextStyle(color: Colors.white60),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- DURATION --------------------
            const Text("Duration Time",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: controller.duration,
              dropdownColor: const Color(0xFF1E1E1E),
              items: controller.durations
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child:
                          Text(e, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => controller.duration = v!),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- SETS --------------------
            const Text("Sets",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: controller.sets,
              dropdownColor: const Color(0xFF1E1E1E),
              items: controller.setsOptions
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child:
                          Text(e, style: const TextStyle(color: Colors.white)),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => controller.sets = v!),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------------------- REPS --------------------
            const Text("Reps",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),

            Row(
              children: [
                // FROM
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: controller.fromReps,
                    dropdownColor: const Color(0xFF1E1E1E),
                    items: List.generate(
                      20,
                      (i) => DropdownMenuItem<int>(
                        value: i + 1,
                        child: Text(
                          "${i + 1}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onChanged: (v) => setState(() => controller.fromReps = v!),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                const Text("To", style: TextStyle(color: Colors.grey)),
                const SizedBox(width: 10),

                // TO
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: controller.toReps,
                    dropdownColor: const Color(0xFF1E1E1E),
                    items: List.generate(
                      20,
                      (i) => DropdownMenuItem<int>(
                        value: i + 1,
                        child: Text(
                          "${i + 1}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onChanged: (v) => setState(() => controller.toReps = v!),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1E1E1E),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // -------------------- VIDEO TITLE --------------------
            if (controller.videoTitleEnabled) ...[
              const Text("Video Title",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              TextField(
                controller: controller.titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter video title",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF1C1C1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],

            // -------------------- VIDEO URL FIELD --------------------
            if (controller.videoUrlEnabled) ...[
              const SizedBox(height: 16),
              const Text("Video URL (Optional)",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              TextFormField(
                controller: controller.urlController,
                style: const TextStyle(color: Colors.white),

                // 🔥 INLINE VALIDATION (inside field)
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null; // optional
                  }

                  final trimmed = value.trim();
                  final regex = RegExp(
                    r'^(https?:\/\/)?([\w\-])+(\.[\w\-]+)+[/#?]?.*$',
                    caseSensitive: false,
                  );

                  if (!regex.hasMatch(trimmed)) {
                    return "Please enter a valid URL";
                  }

                  return null;
                },

                decoration: InputDecoration(
                  hintText: "Paste YouTube or Vimeo URL",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF1C1C1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // -------------------- VIDEO FILE --------------------
            if (controller.videoFileEnabled) ...[
              const Text("Upload Video",
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  await controller.pickVideo();
                  setState(() {});
                },
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Center(
                    child: controller.pickedVideo != null
                        ? Text(
                            "Selected: ${controller.pickedVideo!.path.split('/').last}",
                            style: const TextStyle(color: Colors.white),
                          )
                        : const Text(
                            "Tap to select a video",
                            style: TextStyle(color: Colors.white54),
                          ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),

            // -------------------- SAVE BUTTON --------------------
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8416BC),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.isEdit
                        ? controller.saveEditedWorkout(context)
                        : controller.saveWorkout(context);
                  }
                },
                child: Text(
                  widget.isEdit ? "Save Changes" : "Save",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
