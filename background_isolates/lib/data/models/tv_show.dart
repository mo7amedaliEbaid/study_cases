import '../../domain/entities/tv_show.dart';

class TvShowModel extends TvShowEntity {
  TvShowModel({
    super.id,
    super.name,
    super.permalink,
    super.startDate,
    super.endDate,
    super.country,
    super.network,
    super.status,
    super.imageThumbnailPath,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
      id: json['id'],
      name: json['name'],
      permalink: json['permalink'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      country: json['country'],
      network: json['network'],
      status: json['status'],
      imageThumbnailPath: json['image_thumbnail_path'],
    );
  }

  static List<TvShowEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TvShowModel.fromJson(json)).toList();
  }
}
