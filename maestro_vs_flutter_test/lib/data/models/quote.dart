import '../../domain/entities/quote.dart';

class QuoteModel extends QuoteEntity {
  const QuoteModel({
    required int id,
    required String quote,
    required String author,
  }) : super(
          id: id,
          quote: quote,
          author: author,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      id: json['id'] as int,
      quote: json['quote'] as String,
      author: json['author'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }

  QuoteEntity toEntity() {
    return QuoteEntity(
      id: id,
      quote: quote,
      author: author,
    );
  }
}
