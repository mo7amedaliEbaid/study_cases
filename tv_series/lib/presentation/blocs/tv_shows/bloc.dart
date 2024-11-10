// presentation/bloc/tv_show_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tv_series/presentation/blocs/tv_shows/states.dart';

import '../../../domain/use_cases/tv_shows.dart';
import 'events.dart';

@injectable
class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetMostPopularTvShows getMostPopularTvShows;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  TvShowBloc(this.getMostPopularTvShows) : super(TvShowInitial()) {
    on<FetchMostPopularTvShows>((event, emit) async {
      emit(TvShowLoading());
      try {
        final tvShows = await getMostPopularTvShows(event.page);
        _currentPage = event.page + 1;
        emit(TvShowLoaded(tvShows));
      } catch (e) {
        emit(TvShowError(e.toString()));
      }
    });

    on<LoadMoreTvShows>((event, emit) async {
      if (_isLoadingMore) return; // Prevent multiple simultaneous requests
      _isLoadingMore = true;

      if (state is TvShowLoaded) {
        final currentTvShows = (state as TvShowLoaded).tvShows;
        try {
          final newTvShows = await getMostPopularTvShows(event.page);
          if (newTvShows.isNotEmpty) {
            _currentPage = event.page + 1;
            emit(TvShowLoaded(currentTvShows + newTvShows));
          }
        } catch (e) {
          emit(TvShowError(e.toString()));
        }
      }
      _isLoadingMore = false;
    });
  }

  void fetchMore() => add(LoadMoreTvShows(_currentPage));
}
