import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:_app/database/admin_database/add_vedio_database.dart';

class EditWorkoutController {
  late TextEditingController workoutNameController;
  late TextEditingController titleController;
  late TextEditingController urlController;

  late String workoutName;
  late String duration;
  late String sets;
  late int fromReps;
  late int toReps;

  File? pickedVideo;

  final List<String> durations = [
    "30 minutes",
    "45 minutes",
    "60 minutes",
    "90 minutes"
  ];

  final List<String> setsOptions = ["3 sets", "4 sets", "5 sets"];

  bool videoTitleEnabled = false;
  bool videoUrlEnabled = false;
  bool videoFileEnabled = false;

  final Map<String, String> existingWorkout;

  EditWorkoutController(this.existingWorkout) {
    workoutNameController =
        TextEditingController(text: existingWorkout['name'] ?? "");
    titleController =
        TextEditingController(text: existingWorkout['videoTitle'] ?? "");
    urlController =
        TextEditingController(text: existingWorkout['videoUrl'] ?? "");

    workoutName = existingWorkout['name'] ?? "";

    duration = existingWorkout['duration'] ?? "60 minutes";
    sets = existingWorkout['sets'] ?? "4 sets";

    final reps = existingWorkout['reps']?.split(' - ') ?? ["8", "12"];
    fromReps = int.tryParse(reps[0]) ?? 8;
    toReps = int.tryParse(reps[1]) ?? 12;

    if (existingWorkout['videoFilePath'] != null &&
        existingWorkout['videoFilePath']!.isNotEmpty) {
      pickedVideo = File(existingWorkout['videoFilePath']!);
    }
  }

  ///  LOAD ADMIN VIDEO STATUS
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

  void saveEditedWorkout(BuildContext context) {
    final updatedWorkout = {
      'name': workoutNameController.text.trim(),
      'duration': duration,
      'sets': sets,
      'reps': '$fromReps - $toReps',
      'videoTitle': videoTitleEnabled ? titleController.text.trim() : "",
      'videoUrl': videoUrlEnabled ? urlController.text.trim() : "",
      'videoFilePath': (pickedVideo != null)
          ? pickedVideo!.path
          : (existingWorkout['videoFilePath'] ?? ""),
    };

    Navigator.pop(context, updatedWorkout);
  }
}
