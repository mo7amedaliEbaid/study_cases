import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/domain/use_cases/get_quote_by_id.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/details/details_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetQuoteById extends Mock implements GetQuoteById {}

void main() {
  late QuoteDetailsBloc bloc;
  late MockGetQuoteById mockGetQuoteById;

  setUp(() {
    mockGetQuoteById = MockGetQuoteById();
    bloc = QuoteDetailsBloc(getQuoteById: mockGetQuoteById);
  });

  const tQuote = QuoteEntity(id: 1, quote: 'Test Quote', author: 'Author');

  test('initial state should be QuoteDetailsInitial', () {
    expect(bloc.state, QuoteDetailsInitial());
  });

  blocTest<QuoteDetailsBloc, QuoteDetailsState>(
    'emits [QuoteDetailsLoading, QuoteDetailsLoaded] when getQuoteById succeeds',
    build: () {
      when(() => mockGetQuoteById(1)).thenAnswer((_) async => tQuote);
      return bloc;
    },
    act: (bloc) => bloc.add(const GetQuoteByIdEvent(1)),
    expect: () => [
      QuoteDetailsLoading(),
      const QuoteDetailsLoaded(tQuote),
    ],
    verify: (_) {
      verify(() => mockGetQuoteById(1)).called(1);
    },
  );

  blocTest<QuoteDetailsBloc, QuoteDetailsState>(
    'emits [QuoteDetailsLoading, QuoteDetailsError] when getQuoteById throws',
    build: () {
      when(() => mockGetQuoteById(1)).thenThrow(Exception('Error'));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetQuoteByIdEvent(1)),
    expect: () => [
      QuoteDetailsLoading(),
      isA<QuoteDetailsError>(),
    ],
    verify: (_) {
      verify(() => mockGetQuoteById(1)).called(1);
    },
  );
}
