import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/details/details_bloc.dart';
import 'package:maestro_vs_flutter_test/presentation/blocs/quotes/quotes_bloc.dart';

import 'core/di/di.dart';
import 'presentation/pages/quotes_page.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<QuotesBloc>()..add((GetAllQuotesEvent())),
        ),
        BlocProvider(
          create: (_) => getIt<QuoteDetailsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Quotes App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const QuotesPage(),
      ),
    );
  }
}
