import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:maestro_vs_flutter_test/data/datasources/quote_remote_data_source.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late QuoteRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  // const tQuoteModel = QuoteModel(id: 1, quote: 'Test Quote', author: 'Author');
  const tQuoteEntity =
      QuoteEntity(id: 1, quote: 'Test Quote', author: 'Author');
  /* setUpAll(() {

  });*/
  setUp(() {
    registerFallbackValue(Uri());
    mockHttpClient = MockHttpClient();
    dataSource = QuoteRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getQuotes', () {
    final quotesJson = {
      'quotes': [
        {'id': 1, 'quote': 'Test Quote', 'author': 'Author'}
      ]
    };

    test('should return list of QuoteEntity when the response is 200',
        () async {
      // arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(json.encode(quotesJson), 200));

      // act
      final result = await dataSource.getQuotes();

      // assert
      expect(result, [tQuoteEntity]);
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should throw Exception on failure', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.getQuotes(), throwsA(isA<Exception>()));
    });
  });

  group('getQuoteById', () {
    final quoteJson = {'id': 1, 'quote': 'Test Quote', 'author': 'Author'};

    test('should return QuoteEntity when the response is 200', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(json.encode(quoteJson), 200));

      final result = await dataSource.getQuoteById(1);

      expect(result, tQuoteEntity);
      verify(() => mockHttpClient.get(any())).called(1);
    });

    test('should throw Exception on failure', () async {
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.getQuoteById(1), throwsA(isA<Exception>()));
    });
  });
}
