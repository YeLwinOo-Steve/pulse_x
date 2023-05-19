import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';
import 'package:pulse/src/errors/pulse_errors.dart';
import 'package:pulse/src/view_model/pulse_base_view_model.dart';

typedef PulseVMBuilder<VM> = Widget Function(
  BuildContext context,
  VM model,
  Widget? child,
);

class PulseBuilder<V, VM extends PulseBaseViewModel<V>> extends StatefulWidget {
  const PulseBuilder({
    Key? key,
    required this.viewModel,
    this.child,
    required this.builder,
  }) : super(key: key);
  final VM viewModel;
  final Widget? child;
  final PulseVMBuilder<VM> builder;

  static Type typeOf<T>() => T;

  @override
  State<PulseBuilder> createState() => _PulseBuilderState<V, VM>();
}

class _PulseBuilderState<V, VM extends PulseBaseViewModel<V>>
    extends State<PulseBuilder<V, VM>> {
  late VM vm;
  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    widget.viewModel.onInit();
    vm.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant PulseBuilder<V, VM> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != vm) {
      oldWidget.viewModel.removeListener(_handleChange);
      vm.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    vm.onDispose();
    vm.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PulseSStateManager<VM>(
      viewModel: vm,
      child: widget.builder(
        context,
        vm,
        widget.child,
      ),
    );
  }
}

class PulseSStateManager<VM extends PulseBaseViewModel> extends InheritedWidget {
  const PulseSStateManager({
    super.key,
    required super.child,
    required this.viewModel,
  });
  final VM viewModel;

  static VM? of<VM extends PulseBaseViewModel>(BuildContext context) {
    final provider =
    context.dependOnInheritedWidgetOfExactType<PulseSStateManager<VM>>();
    if (provider == null) {
      PulseErrors.managerNotFoundError(VM);
    }
    return provider?.viewModel;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>
      oldWidget.child != child;
}

