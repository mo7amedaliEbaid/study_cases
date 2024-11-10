// domain/usecases/get_most_popular_tv_shows.dart

import 'package:injectable/injectable.dart';
import 'package:tv_series/data/repositories/tv_shows.dart';

import '../entities/tv_show.dart';

@injectable
class GetMostPopularTvShows {
  final TvShowRepositoryImpl repository;

  GetMostPopularTvShows(this.repository);

  Future<List<TvShowEntity>> call(int page) async {
    return await repository.getMostPopularTvShows(page);
  }
}
