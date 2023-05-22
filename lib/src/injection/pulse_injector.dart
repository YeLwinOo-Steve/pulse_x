import 'package:pulse/src/errors/pulse_errors.dart';
import 'package:synchronized/synchronized.dart';

/// Very simple and easy to use service locator
/// You register your object creation factory or an instance of an object with [register],
/// or [registerLazySingleton]
/// And retrieve the desired object using [find] or call your locator as function as its a
/// callable class
class PulseInjector {
  PulseInjector._();

  /// Locking to prevent concurrent access of data
  static final Lock _lock = Lock();
  static PulseInjector? _instance;

  final Map<Type, dynamic> _services = {};

  /// get instance of [PulseInjector]
  /// If instance is null, it initializes instance by locking to ensure that
  /// a single async process runs without conflict
  static PulseInjector get instance {
    if (_instance == null) {
      _lock.synchronized(() {
        _instance ??= PulseInjector._();
      });
    }
    return _instance!;
  }

  /// In [register] method, DI container creates a new instance of the registered dependency every time it's requested
  /// On the other hand, a new instance is injected in every injection and ensures that each consumer receives a unique instance
  void register<T>(dynamic service) {
    _services[T] = service;
  }

  /// In [registerLazySingleton] method, DI container creates a new instance of the registered dependency when it's first requested
  /// Subsequent requests will return the same instance that was initially created at the first request
  void registerLazySingleton<T>(T Function() serviceFactory) {
    _services[T] = LazySingleton<T>(serviceFactory);
  }

  /// Get registered dependency in DI container
  /// Specify requested dependency type via [T]
  /// If the requested dependency is not found,
  /// Pulse will throw Injection Error
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
