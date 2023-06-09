import 'package:example/dependency_injection.dart';
import 'package:example/view_models/quotes_view_model.dart';
import 'package:example/views/posts_view.dart';
import 'package:example/views/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:pulse_x/pulse_x.dart';
import 'package:quoter/quoter.dart';

import 'counter_view.dart';

final amber200 = Colors.amber.shade200;
const amber = Colors.amber;

class QuotesView extends StatefulWidget {
  const QuotesView({super.key});

  @override
  State<QuotesView> createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> {
  final viewModel = injector.find<QuotesViewModel>();
  final _navigator = injector.find<PulseXNavigator>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: [
          QuoteCount(),
        ],
      ),
      body: PulseXBuilder(
        viewModel: viewModel,
        builder: (context, model, child) {
          List<Quote> quoteList = model.value;
          return quoteList.isEmpty
              ? const EmptyQuoteView()
              : GridView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: quoteList.length,
                  itemBuilder: (context, index) {
                    Quote quote = quoteList.elementAt(index);
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: amber200,
                      ),
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            quote.quotation,
                            maxLines: 8,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            quote.quotee,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'counter',
            onPressed: () async {
              final data = await _navigator.push(CounterView());
              if(data != null){
                _showSnackBar(data);
              }
            },
            child: const Icon(
              Icons.calculate,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: 'timer',
            onPressed: () {
              _navigator.push(const TimerView());
            },
            child: const Icon(
              Icons.timer,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: 'posts',
            onPressed: () {
              _navigator.push(PostsView());
            },
            child: const Icon(Icons.newspaper),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            heroTag: 'quote',
            onPressed: viewModel.addQuote,
            child: const Icon(Icons.add_comment_rounded),
          ),
        ],
      ),
    );
  }
  void _showSnackBar(dynamic data){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            '🧮 $data',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: indigo,
            ),
          ),
        ),
        backgroundColor: indigo100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 8.0,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 10.0,
        ),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
      ),
    );
  }
}

class QuoteCount extends StatelessWidget {
  QuoteCount({Key? key}) : super(key: key);
  final viewModel = injector.find<QuotesViewModel>();
  @override
  Widget build(BuildContext context) {
    return PulseXBuilder(
      viewModel: viewModel,
      builder: (_, model, __) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          width: kToolbarHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: amber,
          ),
          child: Center(
            child: Text(
              '${model.value.length}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        );
      },
    );
  }
}

class EmptyQuoteView extends StatelessWidget {
  const EmptyQuoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 20 / 9,
          child: Lottie.asset('assets/empty_quote.json'),
        ),
        Text(
          'Create new quotes!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
