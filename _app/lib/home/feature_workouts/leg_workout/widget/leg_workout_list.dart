import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../widget/workouts/workout_card.dart';
import '../../../../widget/dialogue/confirm_delete_dialogue.dart';

class LegWorkoutList extends StatelessWidget {
  final Box box;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const LegWorkoutList({
    super.key,
    required this.box,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (box.isEmpty) {
      return const Center(
        child: Text(
          'No workouts added yet!',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: box.length,
      itemBuilder: (context, index) {
        final workout = Map<String, String>.from(box.getAt(index));

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
