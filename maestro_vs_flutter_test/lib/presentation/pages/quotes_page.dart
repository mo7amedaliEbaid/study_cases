import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/quotes/quotes_bloc.dart';
import 'quote_details_page.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        centerTitle: true,
      ),
      body: BlocBuilder<QuotesBloc, QuotesState>(
        builder: (context, state) {
          if (state is QuotesLoading || state is QuotesInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuotesLoaded) {
            return _buildQuotesList(context, state.quotes);
          } else if (state is QuotesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<QuotesBloc>().add(GetAllQuotesEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildQuotesList(BuildContext context, List quotes) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuoteDetailsPage(quoteId: quote.id),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.quote,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '- ${quote.author}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
