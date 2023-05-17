import 'package:flutter/material.dart';
import 'package:pulse/src/errors/pulse_errors.dart';

import '../view_model/pulse_base_view_model.dart';

class PulseStateManager<VM extends PulseBaseViewModel> extends InheritedWidget {
  const PulseStateManager({
    super.key,
    required super.child,
    required this.viewModel,
  });
  final VM viewModel;

  static VM? of<VM extends PulseBaseViewModel>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<PulseStateManager<VM>>();
    if (provider == null) {
      PulseErrors.managerNotFoundError(VM);
    }
    return provider?.viewModel;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.child != child;
}
