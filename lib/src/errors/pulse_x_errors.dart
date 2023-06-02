import 'package:flutter/foundation.dart';

class PulseXErrors {
  static void streamInitError(v) {
    throw FlutterError.fromParts(
      [
        ErrorSummary('StreamSubscription<$v> is null!'),
        ErrorDescription(
          'An error occurred while processing a stream subscription: The stream subscription of type $v has not been initialized. Please initialize the subscription before using it.',
        ),
      ],
    );
  }

  static void keyNotFoundError(v) {
    throw FlutterError.fromParts(
      [
        ErrorSummary('Key not found error!'),
        ErrorDescription(
          'The provided key $v is not found in the Map. Be sure to add the key & value first!',
        ),
      ],
    );
  }

  static void streamManagerNotFoundError(v) {
    throw FlutterError.fromParts(
      [
        ErrorSummary('$v not found'),
        ErrorDescription(
          'PulseStreamStateManager.of() called with a context that does not contain a ViewModel of type $v',
        ),
      ],
    );
  }

  static void managerNotFoundError(v) {
    throw FlutterError.fromParts(
      [
        ErrorSummary('$v not found'),
        ErrorDescription(
          'PulseStateManager.of() called with a context that does not contain a ViewModel of type $v',
        ),
      ],
    );
  }

  static void injectionError(v) {
    throw FlutterError.fromParts(
      [
        ErrorSummary('Dependency Injection Error: $v has not been injected!'),
        ErrorDescription(
          'Service of type $v is not found! Please ensure that the service has been injected first!',
        ),
      ],
    );
  }

  static void contextNotFoundError() {
    throw FlutterError.fromParts(
      [
        ErrorSummary('Context not found error!'),
        ErrorDescription(
          'Make sure you have properly set the global navigator key.',
        ),
      ],
    );
  }
}
