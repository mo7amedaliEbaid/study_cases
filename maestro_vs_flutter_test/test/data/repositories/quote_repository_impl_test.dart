import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/data/datasources/quote_remote_data_source.dart';
import 'package:maestro_vs_flutter_test/data/repositories/quote_repository_impl.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements QuoteRemoteDataSource {}

void main() {
  late QuoteRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  const tQuoteEntity =
      QuoteEntity(id: 1, quote: 'Test Quote', author: 'Author');

  setUp(() {
    //   registerFallbackValue(Uri());
    mockRemoteDataSource = MockRemoteDataSource();
    repository = QuoteRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getQuotes', () {
    test('should return list of quotes', () async {
      when(() => mockRemoteDataSource.getQuotes())
          .thenAnswer((_) async => [tQuoteEntity]);

      final result = await repository.getQuotes();

      expect(result, [tQuoteEntity]);
      verify(() => mockRemoteDataSource.getQuotes()).called(1);
    });
  });

  group('getQuoteById', () {
    test('should return a quote', () async {
      when(() => mockRemoteDataSource.getQuoteById(1))
          .thenAnswer((_) async => tQuoteEntity);

      final result = await repository.getQuoteById(1);

      expect(result, tQuoteEntity);
      verify(() => mockRemoteDataSource.getQuoteById(1)).called(1);
    });
  });
}
