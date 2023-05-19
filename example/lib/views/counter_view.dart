import 'package:example/dependency_injection.dart';
import 'package:example/view_models/counter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';

final amber500 = Colors.amber.shade500;

class CounterView extends StatelessWidget {
  CounterView({Key? key}) : super(key: key);
  final _navigator = injector.find<PulseNavigator>();
  final counterViewModel = injector.find<CounterViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: PulseBuilder(
          viewModel: counterViewModel,
          builder: (_, model, __) {
            return Text(
              '${model.value}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 150,
                fontWeight: FontWeight.w700,
                color: amber500,
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: counterViewModel.increment,
            child: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: counterViewModel.decrement,
            child: const Icon(
              Icons.remove,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: 'wow',
            onPressed: counterViewModel.wow,
            child: const Text('😲'),
          ),
        ],
      ),
    );
  }
}
