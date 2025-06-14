import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/domain/use_cases/get_quotes.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/quotes/quotes_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetQuotes extends Mock implements GetQuotes {}

void main() {
  late QuotesBloc bloc;
  late MockGetQuotes mockGetQuotes;

  setUp(() {
    mockGetQuotes = MockGetQuotes();
    bloc = QuotesBloc(getQuotes: mockGetQuotes);
  });

  const tQuotes = [
    QuoteEntity(id: 1, quote: 'Test Quote 1', author: 'Author 1'),
    QuoteEntity(id: 2, quote: 'Test Quote 2', author: 'Author 2'),
  ];

  test('initial state should be QuotesInitial', () {
    expect(bloc.state, QuotesInitial());
  });

  blocTest<QuotesBloc, QuotesState>(
    'emits [QuotesLoading, QuotesLoaded] when getQuotes succeeds',
    build: () {
      when(() => mockGetQuotes()).thenAnswer((_) async => tQuotes);
      return bloc;
    },
    act: (bloc) => bloc.add(GetAllQuotesEvent()),
    expect: () => [
      QuotesLoading(),
      const QuotesLoaded(tQuotes),
    ],
    verify: (_) {
      verify(() => mockGetQuotes()).called(1);
    },
  );

  blocTest<QuotesBloc, QuotesState>(
    'emits [QuotesLoading, QuotesError] when getQuotes throws',
    build: () {
      when(() => mockGetQuotes()).thenThrow(Exception('Error'));
      return bloc;
    },
    act: (bloc) => bloc.add(GetAllQuotesEvent()),
    expect: () => [
      QuotesLoading(),
      isA<QuotesError>(),
    ],
    verify: (_) {
      verify(() => mockGetQuotes()).called(1);
    },
  );
}
