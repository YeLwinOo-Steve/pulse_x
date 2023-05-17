import 'package:flutter/cupertino.dart';
import 'package:pulse/pulse.dart';

typedef ReactionDisposer = void Function();
typedef Validator<V extends PulseState> = void Function(V, ReactionDisposer);

class PulseReaction<V extends PulseState> extends ValueNotifier<V> {
  final PulseFutureViewModel model;
  late void Function() _listener;
  final Validator validator;
  bool _isDisposed = false;
  PulseReaction(this.model, this.validator) : super(PulseState.initial() as V) {
    _onInit();
  }

  void _onInit() {
    if (_isDisposed) return;
    _listener = () {
      validator(value, dispose);
      value = model.value as V;
    };
    model.addListener(_listener);
  }

  @override
  void dispose() {
    if (_isDisposed) return;
    model.removeListener(_listener);
    _isDisposed = true;
    super.dispose();
  }

  bool get isDisposed => _isDisposed;
}

ReactionDisposer reactionDisposer<V>(PulseReaction reaction) {
  return reaction.dispose;
}
