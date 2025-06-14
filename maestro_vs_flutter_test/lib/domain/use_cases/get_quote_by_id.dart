import '../entities/quote.dart';
import '../repositories/quote_repository.dart';

class GetQuoteById {
  final QuoteRepository repository;

  GetQuoteById(this.repository);

  Future<QuoteEntity> call(int id) async {
    return await repository.getQuoteById(id);
  }
}
