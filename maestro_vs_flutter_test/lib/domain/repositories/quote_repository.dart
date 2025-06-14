import '../entities/quote.dart';

abstract class QuoteRepository {
  Future<List<QuoteEntity>> getQuotes();
  Future<QuoteEntity> getQuoteById(int id);
}
