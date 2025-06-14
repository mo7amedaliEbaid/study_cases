import 'package:equatable/equatable.dart';

class QuoteEntity extends Equatable {
  final int id;
  final String quote;
  final String author;

  const QuoteEntity({
    required this.id,
    required this.quote,
    required this.author,
  });

  @override
  List<Object> get props => [id, quote, author];
}
