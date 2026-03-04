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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Meal name + edit/delete buttons on top row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    meal['name'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
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
            _divider(),
            if (_hasMacros(meal)) ...[
              _macroBox(meal),
              _divider(),
            ],
            const Text(
              "Ingredients",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _ingredientList(meal['ingredients']),
            _divider(),
            const Text(
              "Preparation",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _stepList(meal['steps']),
          ],
        ),
      ),
    );
  }

  // 🧩 Divider
  static Widget _divider() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 1,
        color: Colors.white12,
      );

  // 🧩 Macros section
  static bool _hasMacros(Map<String, String> m) => [
        m['protein'],
        m['carbs'],
        m['fats'],
        m['calories']
      ].any((v) => (v ?? '').isNotEmpty);

  static Widget _macroBox(Map<String, String> m) => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(children: [
          _macroRow("Protein", m['protein'], "g"),
          _macroRow("Carbs", m['carbs'], "g"),
          _macroRow("Fat", m['fats'], "g"),
          _macroRow("Calories", m['calories'], "kcal"),
        ]),
      );

  static Widget _macroRow(String l, String? v, String u) =>
      v == null || v.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13)),
                  Text("$v$u",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold))
                ],
              ),
            );

  // 🧩 Ingredients
  static Widget _ingredientList(String? data) {
    if (data == null || data.trim().isEmpty) {
      return const Text("Not specified",
          style: TextStyle(color: Colors.white70, fontSize: 13));
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
      children: ingredientList
          .map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(item['ingredient'] ?? '',
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4)),
                    ),
                    Text(
                      "${item['quantity']?.isNotEmpty == true ? item['quantity'] : ''}"
                      "${item['unit']?.isNotEmpty == true ? ' ${item['unit']}' : ''}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ))
          .toList(),
    );
  }

  // 🧩 Preparation steps
  static Widget _stepList(String? data) {
    if (data == null || data.trim().isEmpty) {
      return const Text("No preparation steps provided.",
          style: TextStyle(color: Colors.white70, fontSize: 13));
    }

    final clean = data.replaceAll(RegExp(r'^\[|\]$'), '');
    final steps = clean
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final text = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$index. ",
                  style: const TextStyle(color: Colors.white54, fontSize: 13)),
              Expanded(
                child: Text(text,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 13, height: 1.4)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
