import 'package:example/models/quotes.dart';
import 'package:logger/logger.dart';
import 'package:pulse/pulse.dart';
import 'package:quoter/quoter.dart';



class QuotesViewModel extends PulseListViewModel<Quote> {
  final Quoter _quoter = const Quoter();

  void addQuote() {
    Quote quote = generateRandomQuote();
    addValue(quote);
  }

  Quote generateRandomQuote() {
    return _quoter.getRandomQuote();
  }
}
