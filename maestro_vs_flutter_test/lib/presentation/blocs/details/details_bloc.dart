import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/quote.dart';
import '../../../domain/use_cases/get_quote_by_id.dart';

abstract class QuoteDetailsEvent extends Equatable {
  const QuoteDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetQuoteByIdEvent extends QuoteDetailsEvent {
  final int id;

  const GetQuoteByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

abstract class QuoteDetailsState extends Equatable {
  const QuoteDetailsState();

  @override
  List<Object?> get props => [];
}

class QuoteDetailsInitial extends QuoteDetailsState {}

class QuoteDetailsLoading extends QuoteDetailsState {}

class QuoteDetailsLoaded extends QuoteDetailsState {
  final QuoteEntity quote;

  const QuoteDetailsLoaded(this.quote);

  @override
  List<Object?> get props => [quote];
}

class QuoteDetailsError extends QuoteDetailsState {
  final String message;

  const QuoteDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuoteDetailsBloc extends Bloc<QuoteDetailsEvent, QuoteDetailsState> {
  final GetQuoteById getQuoteById;

  QuoteDetailsBloc({required this.getQuoteById})
      : super(QuoteDetailsInitial()) {
    on<GetQuoteByIdEvent>(_onGetQuoteById);
  }

  Future<void> _onGetQuoteById(
      GetQuoteByIdEvent event, Emitter<QuoteDetailsState> emit) async {
    emit(QuoteDetailsLoading());
    try {
      final quote = await getQuoteById(event.id);
      emit(QuoteDetailsLoaded(quote));
    } catch (e) {
      emit(QuoteDetailsError(e.toString()));
    }
  }
}
