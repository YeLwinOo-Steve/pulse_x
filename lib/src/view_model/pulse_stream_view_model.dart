import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pulse/pulse.dart';
import 'package:pulse/src/errors/pulse_errors.dart';



abstract class PulseStreamViewModel<V> extends ChangeNotifier {
  PulseStatus status = PulseStatus.initial;

  final StreamController<V> _controller = StreamController<V>.broadcast();
  Stream<V> get stream => _controller.stream;
  bool get _isStreamPaused => _streamSubscription?.isPaused ?? false;

  StreamSubscription<V>? _streamSubscription;

  void onInit() {
    _streamSubscription = stream.listen(
      (_) {
        if (!_isStreamPaused) {
          update();
        }
      },
      onError: ((error, stackTrace) {}),
      onDone: (() {
        _streamSubscription?.cancel();
      }),
    );
  }

  void addValue(V data) {
    if (!_controller.isClosed && !_controller.isPaused) {
      _controller.sink.add(data);
    }
  }
  void pause() {
    assert(
    _streamSubscription != null,
    PulseErrors.streamInitError(V),
    );
    _streamSubscription?.pause();
  }

  void resume() {
    assert(
    _streamSubscription != null,
    PulseErrors.streamInitError(V),
    );
    _streamSubscription?.resume();
  }

  void update() {
    notifyListeners();
  }

  void onDispose() {
    _streamSubscription?.cancel();
    _controller.close();
    super.dispose();
  }

  void streamInitError() {
    throw FlutterError.fromParts(
      throw FlutterError.fromParts(
        [
          ErrorSummary('StreamSubscription<$V> is null!'),
          ErrorDescription(
            'An error occurred while processing a stream subscription: The stream subscription of type $V has not been initialized. Please initialize the subscription before using it.',
          ),
        ],
      ),
    );
  }
}
