// test/domain/usecases/get_most_popular_tv_shows_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:background/data/repositories/tv_shows.dart';
import 'package:background/domain/entities/tv_show.dart';
import 'package:background/domain/use_cases/tv_shows.dart';

import 'tv_shows_use_case_test.mocks.dart';

@GenerateMocks([TvShowRepositoryImpl])
void main() {
  late MockTvShowRepositoryImpl mockTvShowRepository;
  late GetMostPopularTvShows usecase;
  // Arrange
  setUp(() {
    mockTvShowRepository = MockTvShowRepositoryImpl();
    usecase = GetMostPopularTvShows(mockTvShowRepository);
  });

  final tvShowList = [TvShowEntity(id: 1, name: 'Stranger Things')];
  // Act
  test('should get a list of popular TV shows from the repository', () async {
    when(mockTvShowRepository.getMostPopularTvShows(1))
        .thenAnswer((_) async => tvShowList);

    final result = await usecase(1);
    // Assert
    expect(result, tvShowList);
    verify(mockTvShowRepository.getMostPopularTvShows(1));
    verifyNoMoreInteractions(mockTvShowRepository);
  });
}
