import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pulse_x/pulse_x.dart';
import 'package:pulse_x/src/errors/pulse_x_errors.dart';

/// An abstract [PulseXStreamViewModel] that holds generic type [V].
/// [PulseXStreamViewModel] extends [ChangeNotifier]
/// You don't need to care about [StreamController] and [Stream], PulseX will automatically handle them
/// If you wanna add data to [Stream] via sink, use [addValue] method
/// You can pause, resume or update stream by calling method [pause] & [resume] & [update]
/// NOTE: be sure to call [dispose] method to avoid memory leak
abstract class PulseXStreamViewModel<V> extends ChangeNotifier {
  PulseXStatus status = PulseXStatus.initial;

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
      PulseXErrors.streamInitError(V),
    );
    _streamSubscription?.pause();
  }

  void resume() {
    assert(
      _streamSubscription != null,
      PulseXErrors.streamInitError(V),
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
