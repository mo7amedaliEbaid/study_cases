import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/quote_remote_data_source.dart';
import 'data/repositories/quote_repository_impl.dart';
import 'presentation/bloc/quotes_bloc.dart';
import 'presentation/pages/quotes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<QuotesBloc>(
            create: (context) {
              final remoteDataSource =
                  QuoteRemoteDataSourceImpl(client: http.Client());
              final repository =
                  QuoteRepositoryImpl(remoteDataSource: remoteDataSource);
              return QuotesBloc(repository: repository);
            },
          ),
        ],
        child: const QuotesPage(),
      ),
    );
  }
}
