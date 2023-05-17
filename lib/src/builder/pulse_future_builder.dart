import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';

typedef PulseVMBuilder<V extends PulseState> = Widget Function(
  BuildContext context,
  V state,
  Widget? child,
);

class PulseFutureBuilder<V extends PulseState,
    VM extends PulseFutureViewModel<V>> extends StatefulWidget {
  const PulseFutureBuilder({
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
  State<PulseFutureBuilder> createState() => _PulseFutureBuilderState<V, VM>();
}

class _PulseFutureBuilderState<V extends PulseState,
        VM extends PulseFutureViewModel<V>>
    extends State<PulseFutureBuilder<V, VM>> {
  late V value;
  late VM vm;

  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    vm.onInit();
    value = vm.value;
    vm.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant PulseFutureBuilder<V, VM> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel.value != vm.value) {
      oldWidget.viewModel.removeListener(_handleChange);
      vm.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    vm.removeListener(_handleChange);
    vm.onDispose();
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
