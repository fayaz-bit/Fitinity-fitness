import 'dart:async';

class TimerController {
  int? selectedMinutes = 5; // ✅ nullable now
  int remainingSeconds = 300;
  bool isRunning = false;
  Timer? timer;

  final List<int> timerOptions = [1, 5, 10, 30, 45];

  // INITIALIZE
  void init() {
    if (selectedMinutes != null) {
      remainingSeconds = selectedMinutes! * 60;
    }
  }

  // START TIMER
  void start(Function onTick, Function onFinish) {
    if (isRunning || selectedMinutes == null) return;

    isRunning = true;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        onTick();
      } else {
        t.cancel();
        isRunning = false;

        // 🔥 Unselect minute after completion
        selectedMinutes = null;

        onFinish();
      }
    });
  }

  // PAUSE
  void pause(Function refresh) {
    timer?.cancel();
    isRunning = false;
    refresh();
  }

  // FINISH (manual stop)
  void finish(Function refresh) {
    if (!isRunning) return;

    timer?.cancel();
    isRunning = false;
    remainingSeconds = 0;

    selectedMinutes = null;

    refresh();
  }

  // RESET (back to selected time if exists)
  void reset(Function refresh) {
    timer?.cancel();
    isRunning = false;

    if (selectedMinutes != null) {
      remainingSeconds = selectedMinutes! * 60;
    }

    refresh();
  }

  // CHANGE MINUTES
  void changeMinutes(int min, Function refresh) {
    if (!isRunning) {
      selectedMinutes = min;
      remainingSeconds = min * 60;
      refresh();
    }
  }

  // FORMAT TIME
  String formatTime() {
    int min = remainingSeconds ~/ 60;
    int sec = remainingSeconds % 60;
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  void dispose() {
    timer?.cancel();
  }
}
