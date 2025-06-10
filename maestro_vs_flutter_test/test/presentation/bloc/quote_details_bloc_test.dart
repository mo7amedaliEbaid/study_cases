import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:maestro_vs_flutter_test/domain/repositories/quote_repository.dart';
import 'package:maestro_vs_flutter_test/presentation/bloc/quote_details_bloc.dart';
import '../../domain/repositories/mock_quote_repository.mocks.dart';

void main() {
  late QuoteDetailsBloc quoteDetailsBloc;
  late QuoteRepository mockRepository;

  setUp(() {
    mockRepository = MockQuoteRepository();
    quoteDetailsBloc = QuoteDetailsBloc(repository: mockRepository);
  });

  tearDown(() {
    quoteDetailsBloc.close();
  });

  test('initial state should be QuoteDetailsInitial', () {
    expect(quoteDetailsBloc.state, isA<QuoteDetailsInitial>());
  });

  blocTest<QuoteDetailsBloc, QuoteDetailsState>(
    'emits [QuoteDetailsLoading, QuoteDetailsLoaded] when GetQuoteDetails is added',
    build: () => quoteDetailsBloc,
    act: (bloc) => bloc.add(const GetQuoteDetails(1)),
    expect: () => [
      isA<QuoteDetailsLoading>(),
      isA<QuoteDetailsLoaded>().having(
        (state) => state.quote.id,
        'quote id',
        1,
      ),
    ],
  );

  blocTest<QuoteDetailsBloc, QuoteDetailsState>(
    'emits [QuoteDetailsLoading, QuoteDetailsError] when repository throws exception',
    build: () {
      final mockRepository = MockQuoteRepository();
      return QuoteDetailsBloc(repository: mockRepository);
    },
    act: (bloc) => bloc.add(const GetQuoteDetails(1)),
    expect: () => [
      isA<QuoteDetailsLoading>(),
      isA<QuoteDetailsError>(),
    ],
  );
} 