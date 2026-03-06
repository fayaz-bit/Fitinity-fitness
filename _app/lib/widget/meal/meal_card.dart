import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final Map<String, String> meal;
  final int index;
  final VoidCallback? onTap;
  final Widget? trailing;

  const MealCard({
    super.key,
    required this.meal,
    required this.index,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 22),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 8,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    meal['name'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),

            /// Description
            if ((meal['description'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                meal['description']!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],

            const SizedBox(height: 14),

            /// Macros
            if (_hasMacros(meal)) _macroChips(meal),

            const SizedBox(height: 16),

            /// Ingredients
            const Text(
              "Ingredients",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _ingredientList(meal['ingredients']),

            const SizedBox(height: 16),

            /// Preparation
            const Text(
              "Preparation",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            _stepList(meal['steps']),
          ],
        ),
      ),
    );
  }

  /// ---------- MACROS ----------

  static bool _hasMacros(Map<String, String> m) {
    return [m['protein'], m['carbs'], m['fats'], m['calories']]
        .any((v) => (v ?? '').isNotEmpty);
  }

  static Widget _macroChips(Map<String, String> m) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _macroChip("Protein", m['protein'], "g", Colors.purple),
        _macroChip("Carbs", m['carbs'], "g", Colors.blue),
        _macroChip("Fat", m['fats'], "g", Colors.orange),
        _macroChip("Calories", m['calories'], "kcal", Colors.green),
      ],
    );
  }

  static Widget _macroChip(String label, String? value, String unit, Color c) {
    if (value == null || value.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: c.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: $value$unit",
        style: TextStyle(
          color: c,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// ---------- INGREDIENTS ----------

  static Widget _ingredientList(String? data) {
    if (data == null || data.trim().isEmpty) {
      return const Text(
        "Not specified",
        style: TextStyle(color: Colors.white70, fontSize: 13),
      );
    }

    final List<Map<String, String>> ingredientList = [];

    try {
      final clean = data.replaceAll(RegExp(r'^\[|\]$'), '');
      final items = clean.split('},');

      for (final raw in items) {
        final cleaned = raw.replaceAll(RegExp(r'[\{\}]'), '').trim();
        if (cleaned.isEmpty) continue;

        final parts = cleaned.split(',');

        final ing = parts.isNotEmpty
            ? parts[0].replaceAll('ingredient:', '').trim()
            : '';

        final qty =
            parts.length > 1 ? parts[1].replaceAll('quantity:', '').trim() : '';

        final unit =
            parts.length > 2 ? parts[2].replaceAll('unit:', '').trim() : '';

        ingredientList.add({
          'ingredient': ing,
          'quantity': qty,
          'unit': unit,
        });
      }
    } catch (e) {
      ingredientList.add({'ingredient': data, 'quantity': '', 'unit': ''});
    }

    return Column(
      children: ingredientList.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Bullet
              const Text(
                "• ",
                style: TextStyle(color: Colors.white70),
              ),

              Expanded(
                child: Text(
                  item['ingredient'] ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ),

              Text(
                "${item['quantity'] ?? ''}${item['unit'] != null ? " ${item['unit']}" : ""}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  /// ---------- STEPS ----------

  static Widget _stepList(String? data) {
    if (data == null || data.trim().isEmpty) {
      return const Text(
        "No preparation steps provided.",
        style: TextStyle(color: Colors.white70, fontSize: 13),
      );
    }

    final clean = data.replaceAll(RegExp(r'^\[|\]$'), '');

    final steps = clean
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return Column(
      children: steps.asMap().entries.map((entry) {
        final i = entry.key + 1;
        final text = entry.value;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Step Number Badge
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "$i",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
