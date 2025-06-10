import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/quote.dart';
import '../../domain/repositories/quote_repository.dart';

// Events
abstract class QuoteDetailsEvent extends Equatable {
  const QuoteDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetQuoteDetails extends QuoteDetailsEvent {
  final int id;

  const GetQuoteDetails(this.id);

  @override
  List<Object> get props => [id];
}

// States
abstract class QuoteDetailsState extends Equatable {
  const QuoteDetailsState();

  @override
  List<Object> get props => [];
}

class QuoteDetailsInitial extends QuoteDetailsState {}

class QuoteDetailsLoading extends QuoteDetailsState {}

class QuoteDetailsLoaded extends QuoteDetailsState {
  final Quote quote;

  const QuoteDetailsLoaded(this.quote);

  @override
  List<Object> get props => [quote];
}

class QuoteDetailsError extends QuoteDetailsState {
  final String message;

  const QuoteDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  final QuoteRepository repository;

  QuoteDetailsBloc({required this.repository}) : super(QuoteDetailsInitial()) {
    on<GetQuoteDetails>(_onGetQuoteDetails);
  }

  Future<void> _onGetQuoteDetails(
    GetQuoteDetails event,
    Emitter<QuoteDetailsState> emit,
  ) async {
    emit(QuoteDetailsLoading());
    try {
      final quote = await repository.getQuoteById(event.id);
      emit(QuoteDetailsLoaded(quote));
    } catch (e) {
      emit(QuoteDetailsError(e.toString()));
    }
  }
} 