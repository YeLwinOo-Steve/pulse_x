import 'package:flutter/foundation.dart';
import 'package:pulse/pulse.dart';
import 'package:pulse/src/view_model/pulse_base_view_model.dart';

class PulseFutureViewModel<V extends PulseState> extends PulseBaseViewModel<V> {
  PulseFutureViewModel() : super(PulseState.initial() as V);

  changeState(PulseState state) {
    value = state as V;
    notifyListeners();
  }

  @override
  void onDispose() {}
  PulseStatus get status => value.status;

}
