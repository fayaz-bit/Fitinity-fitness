import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:_app/home/feature_workouts/workout_flow_page/widget/workout_flow_list.dart';
import '../controllers/workout_flow_controller.dart';

class WorkoutFlowPage extends StatefulWidget {
  const WorkoutFlowPage({super.key});

  @override
  State<WorkoutFlowPage> createState() => _WorkoutFlowPageState();
}

class _WorkoutFlowPageState extends State<WorkoutFlowPage> {
  late WorkoutFlowController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();

    // Status bar black (matches screenshot)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    controller = WorkoutFlowController();

    controller.init(() {
      setState(() => initialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF7B2FF7),
          ),
        ),
      );
    }

    return WorkoutFlowList(controller: controller);
  }
}
