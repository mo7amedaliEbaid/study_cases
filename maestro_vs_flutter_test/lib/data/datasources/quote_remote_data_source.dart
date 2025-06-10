import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/consts/consts.dart';
import '../../domain/entities/quote.dart';

abstract class QuoteRemoteDataSource {
  Future<List<Quote>> getQuotes();
  Future<Quote> getQuoteById(int id);
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final http.Client client;

  QuoteRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Quote>> getQuotes() async {
    final response = await client.get(Uri.parse(URLS.baseUrl));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> quotesJson = jsonResponse['quotes'];
      return quotesJson.map((json) => Quote.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }

  @override
  Future<Quote> getQuoteById(int id) async {
    final response = await client.get(Uri.parse('${URLS.baseUrl}/$id'));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Quote.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load quote');
    }
  }
} 