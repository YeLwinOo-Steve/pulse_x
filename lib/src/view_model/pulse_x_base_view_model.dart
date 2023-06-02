import 'package:flutter/foundation.dart';

/// An abstract [PulseXBaseViewModel] that holds generic type [V].
/// [PulseXBaseViewModel] extends [ValueNotifier] so that a single value can be used
/// When [value] is replaced with something that is not equal to the old
/// value as evaluated by the equality operator ==, this class notifies its
/// listeners.
abstract class PulseXBaseViewModel<V> extends ValueNotifier<V> {
  PulseXBaseViewModel(V val) : super(val);
  void onInit() {}
  void onDispose() {}
}
