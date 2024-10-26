import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/tv_show.dart';
import '../blocs/tv_shows/bloc.dart';
import '../blocs/tv_shows/events.dart';
import '../blocs/tv_shows/states.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  @override
  TvShowScreenState createState() => TvShowScreenState();
}

class TvShowScreenState extends State<TvShowScreen> {
  late TvShowBloc _tvShowBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tvShowBloc = BlocProvider.of<TvShowBloc>(context)
      ..add(FetchMostPopularTvShows(1));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _tvShowBloc.fetchMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular TV Shows')),
      body: BlocBuilder<TvShowBloc, TvShowState>(
        builder: (context, state) {
          if (state is TvShowLoading && state is! TvShowLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TvShowLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.tvShows.length + 1, // Add extra item for loader
              itemBuilder: (context, index) {
                if (index < state.tvShows.length) {
                  final TvShowEntity tvShow = state.tvShows[index];
                  return ListTile(
                    leading: Image.network(
                      tvShow.imageThumbnailPath ??
                          "https://static.hbo.com/game-of-thrones-1-1920x1080.jpg",
                    ),
                    title: Text(tvShow.name ?? "Mohamed ali"),
                    subtitle: Text(tvShow.network ?? "network"),
                  );
                } else {
                  // Loader at the end of the list
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          } else if (state is TvShowError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No TV Shows Available'));
          }
        },
      ),
    );
  }
}
