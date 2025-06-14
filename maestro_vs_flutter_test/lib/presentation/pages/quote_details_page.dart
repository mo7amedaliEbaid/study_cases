import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/details/details_bloc.dart';

class QuoteDetailsPage extends StatefulWidget {
  final int quoteId;

  const QuoteDetailsPage({super.key, required this.quoteId});

  @override
  State<QuoteDetailsPage> createState() => _QuoteDetailsPageState();
}

class _QuoteDetailsPageState extends State<QuoteDetailsPage> {
  @override
  void initState() {
    context.read<QuoteDetailsBloc>().add(GetQuoteByIdEvent(widget.quoteId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Details'),
        centerTitle: true,
      ),
      body: BlocBuilder<QuoteDetailsBloc, QuoteDetailsState>(
        builder: (context, state) {
          if (state is QuoteDetailsLoading || state is QuoteDetailsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuoteDetailsLoaded) {
            return _buildQuoteDetails(state.quote);
          } else if (state is QuoteDetailsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<QuoteDetailsBloc>()
                          .add(GetQuoteByIdEvent(widget.quoteId));
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

  Widget _buildQuoteDetails(quote) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quote.quote,
                    style: const TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '- ${quote.author}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quote Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('ID', quote.id.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
