import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/domain/repositories/quote_repository.dart';
import 'package:maestro_vs_flutter_test/domain/use_cases/get_quotes.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late GetQuotes useCase;
  late MockQuoteRepository mockRepository;

  setUp(() {
    mockRepository = MockQuoteRepository();
    useCase = GetQuotes(mockRepository);
  });

  const tQuoteEntity =
      QuoteEntity(id: 1, quote: 'Test Quote', author: 'Author');

  test('should return quotes from repository', () async {
    // arrange
    when(() => mockRepository.getQuotes())
        .thenAnswer((_) async => [tQuoteEntity]);

    // act
    final result = await useCase();

    // assert
    expect(result, [tQuoteEntity]);
    verify(() => mockRepository.getQuotes()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
