import 'pulse_base_view_model.dart';



abstract class PulseViewModel<V> extends PulseBaseViewModel<V> {
  PulseViewModel(V val) : super(val);
}

abstract class PulseSetViewModel<V> extends PulseBaseViewModel<Set<V>> {
  PulseSetViewModel({Set<V>? value}) : super(value ?? {});

  void addValue(V item) {
    value = Set<V>.from(value)..add(item);
  }

  void removeValue(V item) {
    value = Set<V>.from(value)..remove(item);
  }
}

abstract class PulseListViewModel<V> extends PulseBaseViewModel<List<V>> {
  PulseListViewModel({List<V>? value}) : super(value ?? []);

  void addValue(V item) {
    value = List<V>.from(value)..add(item);
  }

  void removeValue(V item) {
    value = List<V>.from(value)..remove(item);
  }
}

abstract class PulseMapViewModel<K, V> extends PulseBaseViewModel<Map<K, V>> {
  PulseMapViewModel({Map<K, V>? initialValue}) : super(initialValue ?? {});

  void addValue(K key, V value) {
    final updatedMap = Map<K, V>.from(value as Map);
    updatedMap[key] = value;
    value = updatedMap as V;
  }

  void removeValue(K key) {
    final updatedMap = Map<K, V>.from(value);
    updatedMap.remove(key);
    value = updatedMap;
  }

  void clear() {
    value = <K, V>{};
  }
}
