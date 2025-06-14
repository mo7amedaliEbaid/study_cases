import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/quote.dart';
import '../../../domain/use_cases/get_quotes.dart';

abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class GetAllQuotesEvent extends QuotesEvent {}

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object?> get props => [];
}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<QuoteEntity> quotes;

  const QuotesLoaded(this.quotes);

  @override
  List<Object?> get props => [quotes];
}

class QuotesError extends QuotesState {
  final String message;

  const QuotesError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final GetQuotes getQuotes;

  QuotesBloc({required this.getQuotes}) : super(QuotesInitial()) {
    on<GetAllQuotesEvent>(_onGetAllQuotes);
  }

  Future<void> _onGetAllQuotes(
      GetAllQuotesEvent event, Emitter<QuotesState> emit) async {
    emit(QuotesLoading());
    try {
      final quotes = await getQuotes();
      emit(QuotesLoaded(quotes));
    } catch (e) {
      emit(QuotesError(e.toString()));
    }
  }
}
