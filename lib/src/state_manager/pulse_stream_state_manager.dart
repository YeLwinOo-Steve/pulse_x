import 'package:flutter/material.dart';
import 'package:pulse/src/errors/pulse_errors.dart';
import 'package:pulse/src/view_model/pulse_stream_view_model.dart';

class PulseStreamStateManager<VM extends PulseStreamViewModel>
    extends InheritedWidget {
  const PulseStreamStateManager({
    super.key,
    required super.child,
    required this.viewModel,
  });
  final VM viewModel;

  static VM? of<VM extends PulseStreamViewModel>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<PulseStreamStateManager<VM>>();
    if (provider == null) {
      PulseErrors.streamManagerNotFoundError(VM);
    }
    return provider?.viewModel;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.child != child;
}
