/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/quotes/quotes_bloc.dart';
import 'package:maestro_vs_flutter_test/presentation/pages/quotes_page.dart';
import 'package:mocktail/mocktail.dart';

class MockQuotesBloc extends Mock implements QuotesBloc {}

class FakeQuotesState extends Fake implements QuotesState {}

class FakeQuotesEvent extends Fake implements QuotesEvent {}

void main() {
  late MockQuotesBloc mockQuotesBloc;

  setUpAll(() {
    registerFallbackValue(FakeQuotesState());
    registerFallbackValue(FakeQuotesEvent());
  });

  setUp(() {
    mockQuotesBloc = MockQuotesBloc();
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: BlocProvider<QuotesBloc>.value(
        value: mockQuotesBloc,
        child: widget,
      ),
    );
  }

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockQuotesBloc.state).thenReturn(QuotesLoading());

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows list of quotes when state is loaded', (tester) async {
    final quotes = [
      const QuoteEntity(id: 1, quote: 'Test Quote 1', author: 'Author 1'),
      const QuoteEntity(id: 2, quote: 'Test Quote 2', author: 'Author 2'),
    ];
    when(() => mockQuotesBloc.state).thenReturn(QuotesLoaded(quotes));

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    expect(find.text('Test Quote 1'), findsOneWidget);
    expect(find.text('- Author 1'), findsOneWidget);
    expect(find.text('Test Quote 2'), findsOneWidget);
    expect(find.text('- Author 2'), findsOneWidget);
  });

  testWidgets('shows error message and retry button on error', (tester) async {
    when(() => mockQuotesBloc.state)
        .thenReturn(const QuotesError('Error occurred'));

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    expect(find.text('Error occurred'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/details/details_bloc.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/quotes/quotes_bloc.dart';
import 'package:maestro_vs_flutter_test/presentation/pages/quotes_page.dart';
import 'package:mocktail/mocktail.dart';

// Mock + Fallbacks
class MockQuotesBloc extends Mock implements QuotesBloc {}

class FakeQuotesState extends Fake implements QuotesState {}

class FakeQuotesEvent extends Fake implements QuotesEvent {}

class MockQuoteDetailsBloc extends Mock implements QuoteDetailsBloc {}

class FakeQuoteDetailsState extends Fake implements QuoteDetailsState {}

class FakeQuoteDetailsEvent extends Fake implements QuoteDetailsEvent {}

void main() {
  late MockQuotesBloc mockQuotesBloc;

  setUpAll(() {
    registerFallbackValue(FakeQuotesState());
    registerFallbackValue(FakeQuotesEvent());
    registerFallbackValue(FakeQuoteDetailsState());
    registerFallbackValue(FakeQuoteDetailsEvent());
  });

  setUp(() {
    mockQuotesBloc = MockQuotesBloc();

    // Provide a valid stream to avoid type error
    when(() => mockQuotesBloc.stream)
        .thenAnswer((_) => const Stream<QuotesState>.empty());

    // Default state, can be overridden in each test
    when(() => mockQuotesBloc.state).thenReturn(QuotesInitial());
  });

  Widget buildTestableWidget(Widget widget) {
    return MaterialApp(
      home: BlocProvider<QuotesBloc>.value(
        value: mockQuotesBloc,
        child: widget,
      ),
    );
  }

  testWidgets('shows loading indicator when state is loading', (tester) async {
    when(() => mockQuotesBloc.state).thenReturn(QuotesLoading());

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows list of quotes when state is loaded', (tester) async {
    final quotes = [
      const QuoteEntity(id: 1, quote: 'Test Quote 1', author: 'Author 1'),
      const QuoteEntity(id: 2, quote: 'Test Quote 2', author: 'Author 2'),
    ];
    when(() => mockQuotesBloc.state).thenReturn(QuotesLoaded(quotes));

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    expect(find.text('Test Quote 1'), findsOneWidget);
    expect(find.text('- Author 1'), findsOneWidget);
    expect(find.text('Test Quote 2'), findsOneWidget);
    expect(find.text('- Author 2'), findsOneWidget);
  });

  testWidgets('shows error message and retry button on error', (tester) async {
    when(() => mockQuotesBloc.state)
        .thenReturn(const QuotesError('Error occurred'));

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    expect(find.text('Error occurred'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

/*  testWidgets('taps quote card navigates to details', (tester) async {
    final quotes = [
      const QuoteEntity(id: 1, quote: 'Test Quote', author: 'Author'),
    ];
    when(() => mockQuotesBloc.state).thenReturn(QuotesLoaded(quotes));

    await tester.pumpWidget(buildTestableWidget(const QuotesPage()));

    // Tap the card
    await tester.tap(find.text('Test Quote'));
    await tester.pumpAndSettle();

    // Expect navigation (if you set up navigation test)
  });*/
}
