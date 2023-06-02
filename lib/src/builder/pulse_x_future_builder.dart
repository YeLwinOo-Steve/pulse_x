import 'package:flutter/material.dart';
import 'package:pulse_x/pulse_x.dart';

typedef PulseVMBuilder<V extends PulseXState> = Widget Function(
  BuildContext context,
  V state,
  Widget? child,
);

class PulseXFutureBuilder<V extends PulseXState,
    VM extends PulseXFutureViewModel<V>> extends StatefulWidget {
  const PulseXFutureBuilder({
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
  State<PulseXFutureBuilder> createState() => _PulseXFutureBuilderState<V, VM>();
}

class _PulseXFutureBuilderState<V extends PulseXState,
        VM extends PulseXFutureViewModel<V>>
    extends State<PulseXFutureBuilder<V, VM>> {
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
  void didUpdateWidget(covariant PulseXFutureBuilder<V, VM> oldWidget) {
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
    return PulseXStateManager<VM>(
      viewModel: vm,
      child: widget.builder(
        context,
        value,
        widget.child,
      ),
    );
  }
}
