import 'package:flutter/material.dart';
import 'package:pulse_x/src/errors/pulse_x_errors.dart';
import 'package:pulse_x/src/view_model/pulse_x_base_view_model.dart';

/// [PulseXStateManager] extends [InheritedWidget] to manage state across the widget tree
class PulseXStateManager<VM extends PulseXBaseViewModel> extends InheritedWidget {
  const PulseXStateManager({
    super.key,
    required super.child,
    required this.viewModel,
  });
  final VM viewModel;

  /// Call [PulseXStateManager.of] method if you don't wanna make an object of [PulseXStateManager] again\
  /// It will throw error if [PulseXBaseViewModel] of exact type
  /// So be ensure that [PulseXBaseViewModel] has been instantiated first
  static VM? of<VM extends PulseXBaseViewModel>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<PulseXStateManager<VM>>();
    if (provider == null) {
      PulseXErrors.managerNotFoundError(VM);
    }
    return provider?.viewModel;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.child != child;
}
