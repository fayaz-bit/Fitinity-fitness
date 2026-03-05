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

  static const violet = Color(0xFF8416BC);

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget sectionCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- WORKOUT INFO ----------------
            sectionTitle("Workout Information"),

            sectionCard(
              child: Column(
                children: [
                  /// WORKOUT NAME
                  TextField(
                    controller: controller.workoutNameController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (v) => controller.workoutName = v,
                    decoration: InputDecoration(
                      hintText: "Workout name",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF141414),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// DURATION
                  DropdownButtonFormField<String>(
                    value: controller.duration,
                    dropdownColor: const Color(0xFF1E1E1E),
                    items: controller.durations
                        .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => controller.duration = v!),
                    decoration: InputDecoration(
                      labelText: "Duration",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF141414),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// SETS
                  DropdownButtonFormField<String>(
                    value: controller.sets,
                    dropdownColor: const Color(0xFF1E1E1E),
                    items: controller.setsOptions
                        .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e,
                                style: const TextStyle(color: Colors.white)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => controller.sets = v!),
                    decoration: InputDecoration(
                      labelText: "Sets",
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF141414),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// REPS
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: controller.fromReps,
                          dropdownColor: const Color(0xFF1E1E1E),
                          items: List.generate(
                            20,
                            (i) => DropdownMenuItem<int>(
                              value: i + 1,
                              child: Text("${i + 1}",
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          onChanged: (v) =>
                              setState(() => controller.fromReps = v!),
                          decoration: InputDecoration(
                            labelText: "From",
                            labelStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: const Color(0xFF141414),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: controller.toReps,
                          dropdownColor: const Color(0xFF1E1E1E),
                          items: List.generate(
                            20,
                            (i) => DropdownMenuItem<int>(
                              value: i + 1,
                              child: Text("${i + 1}",
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          onChanged: (v) =>
                              setState(() => controller.toReps = v!),
                          decoration: InputDecoration(
                            labelText: "To",
                            labelStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: const Color(0xFF141414),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// ---------------- VIDEO SECTION ----------------
            if (controller.videoTitleEnabled ||
                controller.videoUrlEnabled ||
                controller.videoFileEnabled)
              sectionTitle("Workout Video"),

            if (controller.videoTitleEnabled ||
                controller.videoUrlEnabled ||
                controller.videoFileEnabled)
              sectionCard(
                child: Column(
                  children: [
                    /// VIDEO TITLE
                    if (controller.videoTitleEnabled) ...[
                      TextField(
                        controller: controller.titleController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Video title",
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: const Color(0xFF141414),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    /// VIDEO URL
                    if (controller.videoUrlEnabled) ...[
                      TextFormField(
                        controller: controller.urlController,
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return null;
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
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: const Color(0xFF141414),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],

                    /// VIDEO FILE
                    if (controller.videoFileEnabled)
                      GestureDetector(
                        onTap: () async {
                          await controller.pickVideo();
                          setState(() {});
                        },
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: const Color(0xFF141414),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Center(
                            child: controller.pickedVideo != null
                                ? Text(
                                    "Selected: ${controller.pickedVideo!.path.split('/').last}",
                                    style: const TextStyle(color: Colors.white),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.video_library,
                                          color: Colors.white54, size: 32),
                                      SizedBox(height: 8),
                                      Text(
                                        "Tap to upload video",
                                        style: TextStyle(color: Colors.white54),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 28),

            /// ---------------- SAVE BUTTON ----------------
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: violet,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.isEdit
                        ? controller.saveEditedWorkout(context)
                        : controller.saveWorkout(context);
                  }
                },
                child: Text(
                  widget.isEdit ? "Save Changes" : "Save Workout",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
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
