import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/details/details_bloc.dart';
import 'package:maestro_vs_flutter_test/presentation/pages/quote_details_page.dart';
import 'package:mocktail/mocktail.dart';

// Mock + Fallbacks
class MockQuoteDetailsBloc extends Mock implements QuoteDetailsBloc {}

class FakeQuoteDetailsState extends Fake implements QuoteDetailsState {}

class FakeQuoteDetailsEvent extends Fake implements QuoteDetailsEvent {}

void main() {
  late MockQuoteDetailsBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakeQuoteDetailsState());
    registerFallbackValue(FakeQuoteDetailsEvent());
  });

  setUp(() {
    mockBloc = MockQuoteDetailsBloc();
    when(() => mockBloc.stream)
        .thenAnswer((_) => const Stream<QuoteDetailsState>.empty());
    when(() => mockBloc.state).thenReturn(QuoteDetailsInitial());
  });

  Widget buildTestable(Widget widget) {
    return MaterialApp(
      home: BlocProvider<QuoteDetailsBloc>.value(
        value: mockBloc,
        child: widget,
      ),
    );
  }

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockBloc.state).thenReturn(QuoteDetailsLoading());

    await tester.pumpWidget(buildTestable(const QuoteDetailsPage(quoteId: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows quote details when loaded', (tester) async {
    const quote = QuoteEntity(id: 1, quote: 'Test quote', author: 'Author');
    when(() => mockBloc.state).thenReturn(const QuoteDetailsLoaded(quote));

    await tester.pumpWidget(buildTestable(const QuoteDetailsPage(quoteId: 1)));

    expect(find.text('Test quote'), findsOneWidget);
    expect(find.text('- Author'), findsOneWidget);
    expect(find.text('ID'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('shows error message and retry button on error', (tester) async {
    when(() => mockBloc.state)
        .thenReturn(const QuoteDetailsError('Something went wrong'));

    await tester.pumpWidget(buildTestable(const QuoteDetailsPage(quoteId: 1)));

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('tapping retry button triggers GetQuoteByIdEvent',
      (tester) async {
    when(() => mockBloc.state).thenReturn(const QuoteDetailsError('Error'));

    await tester.pumpWidget(buildTestable(const QuoteDetailsPage(quoteId: 1)));

    clearInteractions(mockBloc);

    await tester.tap(find.text('Retry'));
    await tester.pump();

    verify(() => mockBloc.add(const GetQuoteByIdEvent(1))).called(1);
  });
}
