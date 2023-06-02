import 'package:flutter/material.dart';
import 'package:pulse_x/pulse_x.dart';
import 'package:pulse_x/src/view_model/pulse_x_base_view_model.dart';

typedef PulseVMBuilder<VM> = Widget Function(
  BuildContext context,
  VM model,
  Widget? child,
);

class PulseXBuilder<V, VM extends PulseXBaseViewModel<V>> extends StatefulWidget {
  const PulseXBuilder({
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
  State<PulseXBuilder> createState() => _PulseXBuilderState<V, VM>();
}

class _PulseXBuilderState<V, VM extends PulseXBaseViewModel<V>>
    extends State<PulseXBuilder<V, VM>> {
  late VM vm;
  @override
  void initState() {
    super.initState();
    vm = widget.viewModel;
    vm.onInit();
    vm.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(covariant PulseXBuilder<V, VM> oldWidget) {
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
    return PulseXStateManager<VM>(
      viewModel: vm,
      child: widget.builder(
        context,
        vm,
        widget.child,
      ),
    );
  }
}
