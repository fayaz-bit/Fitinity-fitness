import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../widget/workouts/workout_card.dart';
import '../../../../widget/dialogue/confirm_delete_dialogue.dart'; // ✅ DELETE DIALOG IMPORT

class ShoulderWorkoutList extends StatelessWidget {
  final Box box;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const ShoulderWorkoutList({
    super.key,
    required this.box,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (box.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                size: 70,
                color: Colors.grey.shade700,
              ),
              const SizedBox(height: 20),
              const Text(
                "No Chest Workouts Yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Add your first chest workout to start building your routine.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: box.length,
      itemBuilder: (context, index) {
        final workout = Map<String, String>.from(box.getAt(index) ?? {});

        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: WorkoutCard(
            name: workout['name'] ?? '',
            duration: workout['duration'] ?? '',
            sets: workout['sets'] ?? '',
            reps: workout['reps'] ?? '',
            videoTitle: workout['videoTitle'],
            videoUrl: workout['videoUrl'],
            videoFilePath: workout['videoFilePath'],
            onEdit: () => onEdit(index),
            onDelete: () {
              showConfirmDeleteDialog(
                context,
                onConfirm: () async => await onDelete(index),
              );
            },
          ),
        );
      },
    );
  }
}
