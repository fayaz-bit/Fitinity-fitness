import 'package:_app/widget/dialogue/confirm_delete_dialogue.dart';
import 'package:_app/widget/meal/meal_card.dart';
import 'package:flutter/material.dart';

class AdminGainCategoryList extends StatelessWidget {
  final List<Map<String, String>> meals;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const AdminGainCategoryList({
    super.key,
    required this.meals,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                icon: const Icon(Icons.edit, color: Colors.purpleAccent),
                onPressed: () => onEdit(i),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  showConfirmDeleteDialog(
                    context,
                    onConfirm: () async => onDelete(i),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
