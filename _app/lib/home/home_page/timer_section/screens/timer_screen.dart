import 'package:_app/home/home_page/timer_section/widget/timer_list.dart';
import 'package:flutter/material.dart';
import '../controllers/timer_controller.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final controller = TimerController();

  // Violet gradient (same as TimerList)
  LinearGradient get violetGradient => const LinearGradient(
        colors: [
          Color(0xFF7B2FF7),
          Color(0xFF9A4DFF),
        ],
      );

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// ✅ CENTER DIALOG
  void _showTimerDialog(String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: violetGradient,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Color(0xFF7B2FF7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Timer",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.white24),
        ),
      ),
      body: TimerList(
        controller: controller,

        /// START
        onStart: () {
          controller.start(
            () => setState(() {}),
            () {
              setState(() {});
              _showTimerDialog("⏰ Time's Up!");
            },
          );
        },

        /// PAUSE
        onPause: () {
          controller.pause(() => setState(() {}));
        },

        /// FINISH
        onFinish: () {
          controller.finish(() => setState(() {}));
          _showTimerDialog("Workout Finished ✅");
        },

        /// RESET
        onReset: () {
          controller.reset(() => setState(() {}));
        },

        /// UPDATE
        onUpdate: () => setState(() {}),
      ),
    );
  }
}
