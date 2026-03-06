import 'dart:async';

class TimerController {
  int? selectedMinutes = 5;
  int remainingSeconds = 300;
  bool isRunning = false;

  Timer? timer;

  final List<int> timerOptions = [1, 5, 10, 30, 45];

  void init() {
    if (selectedMinutes != null) {
      remainingSeconds = selectedMinutes! * 60;
    }
  }

  /// START
  void start(Function refresh, Function onFinish) {
    if (isRunning || selectedMinutes == null) return;

    isRunning = true;

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        refresh();
      } else {
        t.cancel();
        isRunning = false;
        selectedMinutes = null;
        refresh();
        onFinish();
      }
    });
  }

  /// PAUSE
  void pause(Function refresh) {
    if (!isRunning) return;

    timer?.cancel();
    isRunning = false;
    refresh();
  }

  /// FINISH
  void finish(Function refresh) {
    timer?.cancel();
    isRunning = false;
    remainingSeconds = 0;
    selectedMinutes = null;
    refresh();
  }

  /// RESET
  void reset(Function refresh) {
    timer?.cancel();
    isRunning = false;

    if (selectedMinutes != null) {
      remainingSeconds = selectedMinutes! * 60;
    } else {
      remainingSeconds = 0;
    }

    refresh();
  }

  /// CHANGE MINUTES
  void changeMinutes(int minutes, Function refresh) {
    if (isRunning) return;

    selectedMinutes = minutes;
    remainingSeconds = minutes * 60;

    refresh();
  }

  /// CUSTOM TIME
  void setCustomMinutes(int minutes, Function refresh) {
    if (isRunning) return;

    selectedMinutes = minutes;
    remainingSeconds = minutes * 60;

    refresh();
  }

  /// FORMAT TIME
  String formatTime() {
    int min = remainingSeconds ~/ 60;
    int sec = remainingSeconds % 60;

    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  void dispose() {
    timer?.cancel();
  }
}
