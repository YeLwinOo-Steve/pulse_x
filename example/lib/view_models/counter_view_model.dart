import 'dart:math';

import 'package:logger/logger.dart';
import 'package:pulse_x/pulse_x.dart';

final _logger = Logger();

class CounterViewModel extends PulseXViewModel<int> {
  CounterViewModel() : super(0);

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }

  void wow() {
    int rand = Random().nextInt(9999);
    value = rand;
  }
}
