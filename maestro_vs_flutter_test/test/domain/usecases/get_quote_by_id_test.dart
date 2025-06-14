import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/domain/repositories/quote_repository.dart';
import 'package:maestro_vs_flutter_test/domain/use_cases/get_quote_by_id.dart';
import 'package:mocktail/mocktail.dart';

class MockQuoteRepository extends Mock implements QuoteRepository {}

void main() {
  late GetQuoteById useCase;
  late MockQuoteRepository mockRepository;

  setUp(() {
    mockRepository = MockQuoteRepository();
    useCase = GetQuoteById(mockRepository);
  });

  const tQuoteEntity =
      QuoteEntity(id: 1, quote: 'Test Quote', author: 'Author');

  test('should return a quote from repository', () async {
    when(() => mockRepository.getQuoteById(1))
        .thenAnswer((_) async => tQuoteEntity);

    final result = await useCase(1);

    expect(result, tQuoteEntity);
    verify(() => mockRepository.getQuoteById(1)).called(1);
  });
}
