import 'package:example/dependency_injection.dart';
import 'package:example/view_models/timer_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pulse_x/pulse_x.dart';

final amber500 = Colors.amber.shade500;

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  final timerViewModel = injector.find<TimerViewModel>();
  @override
  void initState() {
    super.initState();
    timerViewModel.addDateTime();
  }

  @override
  void dispose() {
    timerViewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer'),
      ),
      body: Center(
        child: PulseStreamBuilder(
          viewModel: timerViewModel,
          builder: (_, viewModel, snapshot) {
            if (snapshot.hasData) {
              return TimerLabel(time: snapshot.data.toString());
            } else if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            return CupertinoActivityIndicator(
              radius: 20,
              color: amber500,
            );
          },
        ),
      ),
    );
  }
}

class TimerLabel extends StatelessWidget {
  const TimerLabel({Key? key, required this.time}) : super(key: key);
  final String time;
  @override
  Widget build(BuildContext context) {
    return Text(
      time,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: amber500,
          ),
    );
  }
}
