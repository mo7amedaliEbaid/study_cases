// domain/repositories/tv_show_repository.dart

import '../entities/tv_show.dart';

abstract class TvShowRepository {
  Future<List<TvShowEntity>> getMostPopularTvShows(int page);
}
