// data/datasources/tv_show_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../models/tv_show.dart';

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getMostPopularTvShows(int page);
}

@injectable
class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  final http.Client client;

  TvShowRemoteDataSourceImpl(this.client);

  @override
  Future<List<TvShowModel>> getMostPopularTvShows(int page) async {
    final response = await client.get(
      Uri.parse('https://www.episodate.com/api/most-popular?page=$page'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)['tv_shows'];
      return jsonResponse.map((json) => TvShowModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular TV shows');
    }
  }
}
