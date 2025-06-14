import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/quote_remote_data_source.dart';
import '../../data/repositories/quote_repository_impl.dart';
import '../../domain/repositories/quote_repository.dart';
import '../../domain/use_cases/get_quote_by_id.dart';
import '../../domain/use_cases/get_quotes.dart';
import '../../presentation/blocs/details/details_bloc.dart';
import '../../presentation/blocs/quotes/quotes_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<QuoteRepository>(
    () => QuoteRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerFactory(() => GetQuotes(getIt()));
  getIt.registerFactory(() => GetQuoteById(getIt()));
  getIt.registerFactory(() => QuotesBloc(getQuotes: getIt()));
  getIt.registerFactory(() => QuoteDetailsBloc(getQuoteById: getIt()));
}
