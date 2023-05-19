import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';
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
    vm.onInit();
    vm.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant PulseBuilder<V, VM> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel.value != vm.value) {
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
    return PulseStateManager<VM>(
      viewModel: vm,
      child: widget.builder(
        context,
        vm,
        widget.child,
      ),
    );
  }
}
