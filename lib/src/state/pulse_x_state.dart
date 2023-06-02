import 'package:pulse_x/src/enums/pulse_x_status.dart';

/// Multiple future states occurred when using with [FutureViewModel]
class PulseXState<T> {
  PulseXState({
    this.value,
    this.message,
    this.status = PulseXStatus.initial,
  });
  T? value;
  String? message;
  PulseXStatus status;

  PulseXState copyWith({
    T? value,
    String? message,
    PulseXStatus? status,
  }) =>
      PulseXState(
        value: value,
        message: message,
        status: status ?? PulseXStatus.initial,
      );

  /// Initial state [PulseXState.initial] before api call starts
  factory PulseXState.initial() {
    return PulseXState(
      value: null,
      message: null,
      status: PulseXStatus.initial,
    );
  }

  /// Loading state [PulseXState.loading] starts as soon as api call is started
  factory PulseXState.loading() {
    return PulseXState(
      value: null,
      message: null,
      status: PulseXStatus.loading,
    );
  }

  /// Loaded state [PulseXState.loaded] is the state when api call finishes without error & returns value
  factory PulseXState.loaded(T? value) {
    return PulseXState(
      value: value,
      message: null,
      status: PulseXStatus.loaded,
    );
  }

  /// Error state [PulseXState.error] is when api call finishes with error & return relevant error message
  factory PulseXState.error(String message) {
    return PulseXState(
      value: null,
      message: message,
      status: PulseXStatus.error,
    );
  }
}
