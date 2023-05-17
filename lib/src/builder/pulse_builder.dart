import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';
import 'package:pulse/src/view_model/pulse_base_view_model.dart';

typedef PulseVMBuilder<V> = Widget Function(
  BuildContext context,
  V value,
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
  final PulseVMBuilder<V> builder;

  static Type typeOf<T>() => T;

  @override
  State<PulseBuilder> createState() => _PulseBuilderState<V, VM>();
}

class _PulseBuilderState<V, VM extends PulseBaseViewModel<V>>
    extends State<PulseBuilder<V, VM>> {
  late V value;
  late VM vm;
  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    widget.viewModel.onInit();
    value = vm.value;
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
    value = vm.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PulseStateManager<VM>(
      viewModel: vm,
      child: widget.builder(
        context,
        value,
        widget.child,
      ),
    );
  }
}
