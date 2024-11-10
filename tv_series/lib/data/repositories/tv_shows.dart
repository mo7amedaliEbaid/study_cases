// data/repositories/tv_show_repository_impl.dart

import 'package:injectable/injectable.dart';

import '../../domain/entities/tv_show.dart';

import '../../domain/repositories/tv_shows.dart';
import '../data_sources/remote/tv_show.dart';
@injectable
class TvShowRepositoryImpl implements TvShowRepository {
  final TvShowRemoteDataSourceImpl remoteDataSource;

  TvShowRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TvShowEntity>> getMostPopularTvShows(int page) async {
    final tvShowModels = await remoteDataSource.getMostPopularTvShows(page);
    return tvShowModels; // Directly returning models as entities
  }
}
