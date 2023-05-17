import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';

typedef PulseStreamVMBuilder<V, A extends PulseStreamViewModel> = Widget
    Function(
  BuildContext context,
  A viewModel,
  AsyncSnapshot<V> snapshot,
);

class PulseStreamBuilder<V, VM extends PulseStreamViewModel<V>>
    extends StatefulWidget {
  const PulseStreamBuilder({
    Key? key,
    required this.viewModel,
    required this.builder,
    this.child,
  }) : super(key: key);

  final VM viewModel;
  final Widget? child;
  final PulseStreamVMBuilder<V, VM> builder;

  static VM? watch<VM extends PulseStreamViewModel>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PulseStreamStateManager<VM>>()
        ?.viewModel;
  }

  @override
  State<PulseStreamBuilder> createState() => _PulseStreamBuilderState<V, VM>();
}

class _PulseStreamBuilderState<V, VM extends PulseStreamViewModel<V>>
    extends State<PulseStreamBuilder<V, VM>> {
  late VM vm;
  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    vm.onInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    vm = widget.viewModel;
  }

  @override
  void dispose() {
    vm.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PulseStreamStateManager<VM>(
      viewModel: vm,
      child: StreamBuilder<V>(
        stream: vm.stream,
        builder: (context, AsyncSnapshot<V> snapshot) {
          return widget.builder(
            context,
            vm,
            snapshot,
          );
        },
      ),
    );
  }
}
