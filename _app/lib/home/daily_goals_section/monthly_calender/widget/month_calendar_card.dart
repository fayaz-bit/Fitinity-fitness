import 'package:flutter/material.dart';
import '../controller/monthly_calendar_controller.dart';

class MonthCalendarCard extends StatelessWidget {
  final MonthlyCalendarController controller;
  final VoidCallback refresh;

  const MonthCalendarCard({
    super.key,
    required this.controller,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final activeDay = controller.currentActiveDay;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF15161C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sync, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  "30 Day Plan",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.days.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final day = controller.days[index];

              final isActive = controller.isSameDay(day, activeDay);
              final isCompleted = controller.isCompleted(day);

              Color bgColor;

              if (isCompleted) {
                bgColor = Colors.green;
              } else if (isActive) {
                bgColor = Colors.deepPurple;
              } else {
                bgColor = const Color(0xFF1E1F26);
              }

              return Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isCompleted)
                      const Positioned(
                        bottom: 4,
                        right: 4,
                        child: Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
