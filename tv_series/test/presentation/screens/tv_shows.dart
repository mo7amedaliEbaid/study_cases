/*
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';

import 'package:tv_series/domain/entities/tv_show.dart';
import 'package:tv_series/presentation/blocs/tv_shows/bloc.dart';
import 'package:tv_series/presentation/blocs/tv_shows/states.dart';
import 'package:tv_series/presentation/screen/tv_shows.dart';

// Mock class for TvShowBloc
class MockTvShowBloc extends Mock implements TvShowBloc {}

void main() {
  late MockTvShowBloc mockTvShowBloc;

  setUp(() {
    mockTvShowBloc = MockTvShowBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<TvShowBloc>.value(
        value: mockTvShowBloc,
        child: const TvShowScreen(),
      ),
    );
  }

  testWidgets('displays loading indicator when TvShowLoading state',
      (tester) async {
    when(() => mockTvShowBloc.state).thenReturn(TvShowLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays list of TV shows when TvShowLoaded state',
      (tester) async {
    final tvShows = [
      TvShowEntity(
        id: 1,
        name: 'Test Show 1',
        network: 'Network 1',
        imageThumbnailPath: 'https://example.com/image1.jpg',
      ),
      TvShowEntity(
        id: 2,
        name: 'Test Show 2',
        network: 'Network 2',
        imageThumbnailPath: 'https://example.com/image2.jpg',
      ),
    ];
    when(() => mockTvShowBloc.state).thenAnswer((_)TvShowLoaded(tvShows: tvShows));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Test Show 1'), findsOneWidget);
    expect(find.text('Test Show 2'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('displays error message when TvShowError state', (tester) async {
    const errorMessage = 'Failed to fetch TV shows';
    when(() => mockTvShowBloc.state).thenReturn(TvShowError(errorMessage));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error: $errorMessage'), findsOneWidget);
  });

  testWidgets('displays no TV shows message when empty state', (tester) async {
    when(() => mockTvShowBloc.state).thenReturn(TvShowEmpty());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('No TV Shows Available'), findsOneWidget);
  });
}
*/
