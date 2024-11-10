// presentation/bloc/tv_show_state.dart

import 'package:equatable/equatable.dart';
import '../../../domain/entities/tv_show.dart';

abstract class TvShowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvShowInitial extends TvShowState {}

class TvShowLoading extends TvShowState {}

class TvShowLoaded extends TvShowState {
  final List<TvShowEntity> tvShows;

  TvShowLoaded(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}

class TvShowError extends TvShowState {
  final String message;

  TvShowError(this.message);

  @override
  List<Object?> get props => [message];
}
