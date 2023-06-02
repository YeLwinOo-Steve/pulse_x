import 'package:pulse_x/pulse_x.dart';
import 'package:pulse_x/src/view_model/pulse_x_base_view_model.dart';

/// An abstract [PulseXFutureViewModel] that holds generic type [V].
/// [PulseXFutureViewModel] is used when dealing with API calls,
/// It provides you with four states - initial state, loading state, loaded state, error state
/// You can update [PulseXState] via [changeState] method
/// If you wanna check the current state, use [status] getter method which returns [PulseXStatus] enum
/// [PulseXFutureViewModel] extends [PulseXBaseViewModel] so that a single value can be used
/// When [value] is replaced with something that is not equal to the old
/// value as evaluated by the equality operator ==, this class notifies its
/// listeners.
class PulseXFutureViewModel<V extends PulseXState> extends PulseXBaseViewModel<V> {
  PulseXFutureViewModel() : super(PulseXState.initial() as V);

  changeState(PulseXState state) {
    value = state as V;
    notifyListeners();
  }

  @override
  void onDispose() {}
  PulseXStatus get status => value.status;

}
