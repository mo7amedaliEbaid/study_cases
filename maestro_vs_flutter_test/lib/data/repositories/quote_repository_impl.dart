import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteRemoteDataSource remoteDataSource;

  QuoteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<QuoteEntity>> getQuotes() async {
    return await remoteDataSource.getQuotes();
  }

  @override
  Future<QuoteEntity> getQuoteById(int id) async {
    return await remoteDataSource.getQuoteById(id);
  }
}
