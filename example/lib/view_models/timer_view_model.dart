import 'dart:async';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:pulse_x/pulse_x.dart';

class TimerViewModel extends PulseXStreamViewModel<String> {
  late Timer _timer;
  final DateFormat formattedDate = DateFormat('h:mm:ss a');
  void addDateTime() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        String currentTime = formattedDate.format(DateTime.now());
        addValue(currentTime);
      },
    );
  }

  @override
  void onDispose() {
    _timer.cancel();
  }
}
