import 'package:logger/logger.dart';
import 'package:quoter/quoter.dart';

typedef QuoteSet = Set<Quote>;

class Quotes {
  QuoteSet quotes;
  Quotes({
    required this.quotes,
  });

  Quotes copyWith(QuoteSet quotes) => Quotes(quotes: quotes);
}
