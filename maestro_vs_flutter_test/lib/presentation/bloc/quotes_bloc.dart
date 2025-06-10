import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';

// Events
abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class GetQuotes extends QuotesEvent {}

// States
abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<Quote> quotes;

  const QuotesLoaded(this.quotes);

  @override
  List<Object> get props => [quotes];
}

class QuotesError extends QuotesState {
  final String message;

  const QuotesError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final QuoteRepository repository;

  QuotesBloc({required this.repository}) : super(QuotesInitial()) {
    on<GetQuotes>(_onGetQuotes);
  }

  Future<void> _onGetQuotes(GetQuotes event, Emitter<QuotesState> emit) async {
    emit(QuotesLoading());
    try {
      final quotes = await repository.getQuotes();
      emit(QuotesLoaded(quotes));
    } catch (e) {
      emit(QuotesError(e.toString()));
    }
  }
} 