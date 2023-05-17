import 'package:pulse/src/enums/pulse_status.dart';

class PulseState<T> {
  PulseState({
    this.value,
    this.message,
    this.status = PulseStatus.initial,
  });
  T? value;
  String? message;
  PulseStatus status;

  PulseState copyWith({
    T? value,
    String? message,
    PulseStatus? status,
  }) =>
      PulseState(
        value: value,
        message: message,
        status: status ?? PulseStatus.initial,
      );

  factory PulseState.initial() {
    return PulseState(
      value: null,
      message: null,
      status: PulseStatus.initial,
    );
  }

  factory PulseState.loading() {
    return PulseState(
      value: null,
      message: null,
      status: PulseStatus.loading,
    );
  }
  factory PulseState.loaded(T? value) {
    return PulseState(
      value: value,
      message: null,
      status: PulseStatus.loaded,
    );
  }
  factory PulseState.error(String message) {
    return PulseState(
      value: null,
      message: message,
      status: PulseStatus.error,
    );
  }
}
