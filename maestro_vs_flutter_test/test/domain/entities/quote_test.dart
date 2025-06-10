import 'package:flutter_test/flutter_test.dart';
import 'package:maestro_vs_flutter_test/domain/entities/quote.dart';

void main() {
  group('Quote', () {
    test('should create a Quote from JSON', () {
      // arrange
      final json = {
        'id': 1,
        'quote': 'Test quote',
        'author': 'Test author',
      };

      // act
      final quote = Quote.fromJson(json);

      // assert
      expect(quote.id, 1);
      expect(quote.quote, 'Test quote');
      expect(quote.author, 'Test author');
    });

    test('should throw FormatException when JSON is invalid', () {
      // arrange
      final json = {
        'id': 'invalid', // should be int
        'quote': 'Test quote',
        'author': 'Test author',
      };

      // act & assert
      expect(() => Quote.fromJson(json), throwsFormatException);
    });
  });
} 