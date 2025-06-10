import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:maestro_vs_flutter_test/data/datasources/quote_remote_data_source.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';

@GenerateMocks([http.Client])
import 'quote_remote_data_source_test.mocks.dart';

void main() {
  late QuoteRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = QuoteRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getQuotes', () {
    test('should return list of quotes when response is successful', () async {
      // arrange
      final jsonResponse = {
        'quotes': [
          {
            'id': 1,
            'quote': 'Test quote 1',
            'author': 'Test author 1',
          },
          {
            'id': 2,
            'quote': 'Test quote 2',
            'author': 'Test author 2',
          },
        ],
      };

      when(mockHttpClient.get(Uri.parse('https://dummyjson.com/quotes')))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonResponse), 200));

      // act
      final result = await dataSource.getQuotes();

      // assert
      expect(result, isA<List<Quote>>());
      expect(result.length, 2);
      expect(result[0].id, 1);
      expect(result[0].quote, 'Test quote 1');
      expect(result[0].author, 'Test author 1');
    });

    test('should throw exception when response is not successful', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('https://dummyjson.com/quotes')))
          .thenAnswer((_) async => http.Response('Error', 404));

      // act & assert
      expect(() => dataSource.getQuotes(), throwsException);
    });
  });

  group('getQuoteById', () {
    test('should return quote when response is successful', () async {
      // arrange
      final jsonResponse = {
        'id': 1,
        'quote': 'Test quote',
        'author': 'Test author',
      };

      when(mockHttpClient.get(Uri.parse('https://dummyjson.com/quotes/1')))
          .thenAnswer((_) async => http.Response(jsonEncode(jsonResponse), 200));

      // act
      final result = await dataSource.getQuoteById(1);

      // assert
      expect(result, isA<Quote>());
      expect(result.id, 1);
      expect(result.quote, 'Test quote');
      expect(result.author, 'Test author');
    });

    test('should throw exception when response is not successful', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('https://dummyjson.com/quotes/1')))
          .thenAnswer((_) async => http.Response('Error', 404));

      // act & assert
      expect(() => dataSource.getQuoteById(1), throwsException);
    });
  });
} 