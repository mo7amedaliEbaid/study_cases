// presentation/bloc/tv_show_event.dart

import 'package:equatable/equatable.dart';

abstract class TvShowEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMostPopularTvShows extends TvShowEvent {
  final int page;

  FetchMostPopularTvShows(this.page);

  @override
  List<Object> get props => [page];
}

class LoadMoreTvShows extends TvShowEvent {
  final int page;

  LoadMoreTvShows(this.page);

  @override
  List<Object> get props => [page];
}
