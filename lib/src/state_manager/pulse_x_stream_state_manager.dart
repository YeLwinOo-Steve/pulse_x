import 'package:flutter/material.dart';
import 'package:pulse_x/src/errors/pulse_x_errors.dart';
import 'package:pulse_x/src/view_model/pulse_x_stream_view_model.dart';

/// [PulseXStreamStateManager] extends [InheritedWidget] to manage stream data state across the widget tree
class PulseXStreamStateManager<VM extends PulseXStreamViewModel>
    extends InheritedWidget {
  const PulseXStreamStateManager({
    super.key,
    required super.child,
    required this.viewModel,
  });
  final VM viewModel;

  /// Call [PulseXStreamStateManager.of] method if you don't wanna make an object of [PulseXStreamStateManager] again
  /// It will throw error if [PulseXStreamViewModel] of exact type
  /// So be ensure that [PulseXStreamViewModel] has been instantiated first
  /// Note: [PulseXStreamViewModel] is intended only for stream data
  static VM? of<VM extends PulseXStreamViewModel>(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<PulseXStreamStateManager<VM>>();
    if (provider == null) {
      PulseXErrors.streamManagerNotFoundError(VM);
    }
    return provider?.viewModel;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.child != child;
}
