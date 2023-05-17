import 'package:example/dependency_injection.dart';
import 'package:example/view_models/quotes_view_model.dart';
import 'package:example/views/posts_view.dart';
import 'package:example/views/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:pulse/pulse.dart';
import 'package:quoter/quoter.dart';

final amber200 = Colors.amber.shade200;
const amber = Colors.amber;

class QuotesView extends StatelessWidget {
  QuotesView({super.key});
  final viewModel = injector.find<QuotesViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: [
          QuoteCount(),
        ],
      ),
      body: PulseBuilder(
        viewModel: viewModel,
        builder: (context, List<Quote> value, child) {
          List<Quote> quoteModel = value;
          return quoteModel.isEmpty
              ? const Center(
                  child: Text('Create New Quotes!'),
                )
              : GridView.builder(
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: quoteModel.length,
                  itemBuilder: (context, index) {
                    Quote quote = quoteModel.elementAt(index);
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
            heroTag: 'timer',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TimerView()),
              );
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PostsView()),
              );
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
}

class QuoteCount extends StatelessWidget {
  QuoteCount({Key? key}) : super(key: key);
  final viewModel = injector.find<QuotesViewModel>();
  @override
  Widget build(BuildContext context) {
    return PulseBuilder(
      viewModel: viewModel,
      builder: (_, List<Quote> value, __) {
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
              '${value.length}',
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
