import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/consts/consts.dart';
import '../../domain/entities/quote.dart';
import '../models/quote.dart';

abstract class QuoteRemoteDataSource {
  Future<List<QuoteEntity>> getQuotes();
  Future<QuoteEntity> getQuoteById(int id);
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final http.Client client;

  QuoteRemoteDataSourceImpl({required this.client});

  @override
  Future<List<QuoteEntity>> getQuotes() async {
    final response = await client.get(Uri.parse(URLS.baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> quotesJson = jsonResponse['quotes'];

      return quotesJson
          .map((json) => QuoteModel.fromJson(json))
          .map((model) => model.toEntity())
          .toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  @override
  Future<QuoteEntity> getQuoteById(int id) async {
    final response = await client.get(Uri.parse('${URLS.baseUrl}/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final model = QuoteModel.fromJson(jsonResponse);
      return model.toEntity();
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
