import 'package:_app/home/daily_goals_section/dashboard/controllers/daily_goals_controller.dart';
import 'package:_app/home/daily_goals_section/dashboard/widget/daily_goals_content.dart';
import 'package:flutter/material.dart';

class DailyGoalsScreen extends StatelessWidget {
  DailyGoalsScreen({super.key});

  final DailyGoalsController controller = DailyGoalsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: DailyGoalsContent(
          onSetMeUp: () => controller.onSetMeUp(context),
          onSkip: () => controller.onSkip(context),
        ),
      ),
    );
  }
}
