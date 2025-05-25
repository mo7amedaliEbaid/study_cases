import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../core/consts/consts.dart';
import '../../core/error/exception.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(String cityName);
}

interface class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(URLS.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      log(response.body);
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
