import 'package:flutter/material.dart';
import 'home_scetion.dart';

class HomeSectionList extends StatelessWidget {
  final List<Map<String, dynamic>> sections;
  final Function(String) onTap;

  const HomeSectionList({
    super.key,
    required this.sections,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sections.map((section) {
        return HomeSectionWidget(
          title: section["title"],
          img1: section["images"][0],
          img2: section["images"][1],
          onSeeAll: () => onTap(section["title"]),
        );
      }).toList(),
    );
  }
}
