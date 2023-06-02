import 'package:flutter/cupertino.dart';
import 'package:pulse_x/pulse_x.dart';

typedef ReactionDisposer = void Function();
typedef Validator<V> = void Function(V, ReactionDisposer);

class PulseXReaction<V extends PulseXState> extends ValueNotifier<V> {
  final PulseXFutureViewModel model;
  late void Function() _listener;
  final Validator validator;
  bool _isDisposed = false;
  PulseXReaction(this.model, this.validator) : super(PulseXState.initial() as V) {
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

ReactionDisposer reactionDisposer<V>(PulseXReaction reaction) {
  return reaction.dispose;
}
