import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:_app/database/admin_database/add_vedio_database.dart';

class NewWorkoutController {
  late String workoutName;
  late String duration;
  late String sets;
  late int fromReps;
  late int toReps;

  bool videoTitleEnabled = false;
  bool videoUrlEnabled = false;
  bool videoFileEnabled = false;

  final List<String> durations = [
    "30 minutes",
    "45 minutes",
    "60 minutes",
    "90 minutes"
  ];

  final List<String> setsOptions = ["3 sets", "4 sets", "5 sets"];

  late TextEditingController workoutNameController;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  File? pickedVideo;

  NewWorkoutController(Map<String, String>? workout) {
    workoutName = workout?['name'] ?? "My Awesome Workout";
    duration = workout?['duration'] ?? "60 minutes";
    sets = workout?['sets'] ?? "4 sets";

    if (workout?['reps'] != null) {
      final reps = workout!['reps']!.split(' - ');
      fromReps = int.tryParse(reps[0]) ?? 8;
      toReps = int.tryParse(reps[1]) ?? 12;
    } else {
      fromReps = 8;
      toReps = 12;
    }

    workoutNameController = TextEditingController(text: workoutName);
  }

  /// 🔥 LOAD ADMIN VIDEO STATUS
  Future<void> loadVideoSettings() async {
    final status = await AdminVideosDB.getFieldsStatus();

    videoTitleEnabled = status;
    videoUrlEnabled = status;
    videoFileEnabled = status;
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      pickedVideo = File(video.path);
    }
  }

  void saveWorkout(BuildContext context) {
    final workoutData = {
      'name': workoutNameController.text.trim(),
      'duration': duration,
      'sets': sets,
      'reps': '$fromReps - $toReps',
      'videoTitle': videoTitleEnabled ? titleController.text.trim() : "",
      'videoUrl': videoUrlEnabled ? urlController.text.trim() : "",
    };

    if (videoFileEnabled && pickedVideo != null) {
      workoutData['videoFilePath'] = pickedVideo!.path;
    }

    Navigator.pop(context, workoutData);
  }
}
