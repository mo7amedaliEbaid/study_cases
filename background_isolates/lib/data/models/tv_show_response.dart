import 'package:background/data/models/tv_show.dart';

import '../../domain/entities/tv_show.dart';

class TvShowResponse {
  final int total;
  final int page;
  final int pages;
  final List<TvShowEntity> tvShows;

  TvShowResponse({
    required this.total,
    required this.page,
    required this.pages,
    required this.tvShows,
  });

  factory TvShowResponse.fromJson(Map<String, dynamic> json) {
    return TvShowResponse(
      total: int.parse(json['total']),
      page: json['page'],
      pages: json['pages'],
      tvShows: TvShowModel.fromJsonList(json['tv_shows']),
    );
  }
}
