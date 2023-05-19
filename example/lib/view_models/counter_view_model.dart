import 'dart:math';

import 'package:logger/logger.dart';
import 'package:pulse/pulse.dart';

final _logger = Logger();

class CounterViewModel extends PulseViewModel<int> {
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
