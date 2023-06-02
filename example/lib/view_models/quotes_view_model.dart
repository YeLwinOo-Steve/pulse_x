import 'package:example/models/quotes.dart';
import 'package:logger/logger.dart';
import 'package:pulse_x/pulse_x.dart';
import 'package:quoter/quoter.dart';



class QuotesViewModel extends PulseXListViewModel<Quote> {
  final Quoter _quoter = const Quoter();

  void addQuote() {
    Quote quote = generateRandomQuote();
    addValue(quote);
  }

  Quote generateRandomQuote() {
    return _quoter.getRandomQuote();
  }
}
