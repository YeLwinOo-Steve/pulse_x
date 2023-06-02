import 'package:pulse_x/src/errors/pulse_x_errors.dart';

import 'pulse_x_base_view_model.dart';

/// An abstract [PulseXViewModel] that holds generic type [V].
/// [PulseXBaseViewModel] is intended for simple data types such as String, int, double, etc
/// [PulseXBaseViewModel] extends [PulseXBaseViewModel]
/// When [value] is replaced with something that is not equal to the old
/// value as evaluated by the equality operator ==, this class notifies its
/// listeners.
abstract class PulseXViewModel<V> extends PulseXBaseViewModel<V> {
  PulseXViewModel(V val) : super(val);
}

/// [PulseXSetViewModel] is intended for Set data type of generic type [V]
/// If you wanna add value to set, use [addValue] method
/// To remove value from set, use [removeValue] method
abstract class PulseXSetViewModel<V> extends PulseXBaseViewModel<Set<V>> {
  PulseXSetViewModel({Set<V>? value}) : super(value ?? {});

  void addValue(V item) {
    value = Set<V>.from(value)..add(item);
  }

  void removeValue(V item) {
    value = Set<V>.from(value)..remove(item);
  }
}

/// [PulseXListViewModel] is intended for List data type of generic type [V]
/// If you wanna add value to the list, use [addValue] method
/// To remove value from the list, use [removeValue] method
abstract class PulseXListViewModel<V> extends PulseXBaseViewModel<List<V>> {
  PulseXListViewModel({List<V>? value}) : super(value ?? []);

  void addValue(V item) {
    value = List<V>.from(value)..add(item);
  }

  void removeValue(V item) {
    value = List<V>.from(value)..remove(item);
  }
}

/// [PulseXMapViewModel] is intended for Map data type of generic type [V]
/// If you wanna add value to the Map, use [addValue] method with key & value
/// To remove value from the list, use [removeValue] method with key
/// When removing value from the Map, if [key] is not present in the Map
/// PulseX will throw [keyNotFoundError]
/// To empty Map, use [clear] method
abstract class PulseXMapViewModel<K, V> extends PulseXBaseViewModel<Map<K, V>> {
  PulseXMapViewModel({Map<K, V>? initialValue}) : super(initialValue ?? {});

  void addValue(K key, V value) {
    final updatedMap = Map<K, V>.from(value as Map);
    updatedMap[key] = value;
    value = updatedMap as V;
  }

  void removeValue(K key) {
    assert(
      value.containsKey(key),
      PulseXErrors.keyNotFoundError(key),
    );
    final updatedMap = Map<K, V>.from(value);
    updatedMap.remove(key);
    value = updatedMap;
  }

  void clear() {
    value = <K, V>{};
  }
}
