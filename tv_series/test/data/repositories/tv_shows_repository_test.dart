// test/data/repositories/tv_show_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/data_sources/remote/tv_show.dart';
import 'package:tv_series/data/models/tv_show.dart';
import 'package:tv_series/data/repositories/tv_shows.dart';

import 'tv_shows_repository_test.mocks.dart';

@GenerateMocks([TvShowRemoteDataSourceImpl])
void main() {
  late MockTvShowRemoteDataSourceImpl mockDataSource;
  late TvShowRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockTvShowRemoteDataSourceImpl();
    repository = TvShowRepositoryImpl(mockDataSource);
  });

  final tvShowList = [TvShowModel(id: 1, name: 'Stranger Things')];

  test('should return data when the call to remote data source is successful',
      () async {
    when(mockDataSource.getMostPopularTvShows(any))
        .thenAnswer((_) async => tvShowList);

    final result = await repository.getMostPopularTvShows(1);

    expect(result, tvShowList);
    verify(mockDataSource.getMostPopularTvShows(1));
    verifyNoMoreInteractions(mockDataSource);
  });
}
