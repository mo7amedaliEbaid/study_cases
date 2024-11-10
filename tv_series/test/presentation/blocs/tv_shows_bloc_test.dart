// test/presentation/bloc/tv_show_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_show.dart';
import 'package:tv_series/domain/use_cases/tv_shows.dart';
import 'package:tv_series/presentation/blocs/tv_shows/bloc.dart';
import 'package:tv_series/presentation/blocs/tv_shows/events.dart';
import 'package:tv_series/presentation/blocs/tv_shows/states.dart';

import 'tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetMostPopularTvShows])
void main() {
  late MockGetMostPopularTvShows mockGetMostPopularTvShows;
  late TvShowBloc bloc;

  setUp(() {
    mockGetMostPopularTvShows = MockGetMostPopularTvShows();
    bloc = TvShowBloc(mockGetMostPopularTvShows);
  });

  final tvShowList = [TvShowEntity(id: 1, name: 'Stranger Things')];

  blocTest<TvShowBloc, TvShowState>(
    'emits [TvShowLoading, TvShowLoaded] when TvShowFetchPopular event is added',
    build: () {
      when(mockGetMostPopularTvShows(any)).thenAnswer((_) async => tvShowList);
      return bloc;
    },
    act: (bloc) => bloc.add(FetchMostPopularTvShows(1)),
    expect: () => [
      TvShowLoading(),
      TvShowLoaded(tvShowList),
    ],
  );

  blocTest<TvShowBloc, TvShowState>(
    'emits [TvShowLoading, TvShowError] when TvShowFetchPopular fails',
    build: () {
      when(mockGetMostPopularTvShows(any)).thenThrow('Failed to load');
      return bloc;
    },
    act: (bloc) => bloc.add(FetchMostPopularTvShows(1)),
    expect: () => [
      TvShowLoading(),
      TvShowError('Failed to load'),
    ],
  );
}
