import 'package:pulse/src/errors/pulse_errors.dart';
import 'package:synchronized/synchronized.dart';

/// Very simple and easy to use service locator
/// You register your object creation factory or an instance of an object with [register],
/// or [registerLazySingleton]
/// And retrieve the desired object using [find] or call your locator as function as its a
/// callable class
class PulseInjector {
  PulseInjector._();

  static final Lock _lock = Lock();
  static PulseInjector? _instance;

  final Map<Type, dynamic> _services = {};

  static PulseInjector get instance {
    if (_instance == null) {
      _lock.synchronized(() {
        _instance ??= PulseInjector._();
      });
    }
    return _instance!;
  }

  void register<T>(dynamic service) {
    _services[T] = service;
  }

  void registerLazySingleton<T>(T Function() serviceFactory) {
    _services[T] = LazySingleton<T>(serviceFactory);
  }

  T find<T>() {
    final dynamic service = _services[T];
    /// throw dependency injection error if service[T] has not been injected yet
    assert(service != null, PulseErrors.injectionError(T));
    if (service is LazySingleton<T>) {
      return service.instance;
    }
    return service as T;
  }
}

class LazySingleton<T> {
  LazySingleton(this._serviceFactory);
  final dynamic Function() _serviceFactory;
  T? _instance;

  T get instance {
    _instance ??= _serviceFactory();
    return _instance!;
  }
}
