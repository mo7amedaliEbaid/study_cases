import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:maestro_vs_flutter_test/domain/repositories/quote_repository.dart';
import 'package:maestro_vs_flutter_test/presentation/bloc/quotes_bloc.dart';
import '../../domain/repositories/mock_quote_repository.mocks.dart';

void main() {
  late QuotesBloc quotesBloc;
  late QuoteRepository mockRepository;

  setUp(() {
    mockRepository = MockQuoteRepository();
    quotesBloc = QuotesBloc(repository: mockRepository);
  });

  tearDown(() {
    quotesBloc.close();
  });

  test('initial state should be QuotesInitial', () {
    expect(quotesBloc.state, isA<QuotesInitial>());
  });

  blocTest<QuotesBloc, QuotesState>(
    'emits [QuotesLoading, QuotesLoaded] when GetQuotes is added',
    build: () => quotesBloc,
    act: (bloc) => bloc.add(GetQuotes()),
    expect: () => [
      isA<QuotesLoading>(),
      isA<QuotesLoaded>().having(
        (state) => state.quotes.length,
        'quotes length',
        2,
      ),
    ],
  );

  blocTest<QuotesBloc, QuotesState>(
    'emits [QuotesLoading, QuotesError] when repository throws exception',
    build: () {
      final mockRepository = MockQuoteRepository();
      return QuotesBloc(repository: mockRepository);
    },
    act: (bloc) => bloc.add(GetQuotes()),
    expect: () => [
      isA<QuotesLoading>(),
      isA<QuotesError>(),
    ],
  );
} 