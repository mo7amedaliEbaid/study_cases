import 'dart:async';
import 'dart:isolate';
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
  ReceivePort? _receivePort;
  Isolate? _fetchingIsolate;

  @override
  void initState() {
    super.initState();
    _tvShowBloc = BlocProvider.of<TvShowBloc>(context)
      ..add(FetchMostPopularTvShows(1));

    _startBackgroundFetching();
  }

  Future<void> _startBackgroundFetching() async {
    _receivePort = ReceivePort();
    _fetchingIsolate = await Isolate.spawn(_backgroundFetch, _receivePort!.sendPort);

    _receivePort!.listen((_) {
      // Fetch new TV shows when we receive a message from the isolate
      _tvShowBloc.add(FetchMostPopularTvShows(1));
    });
  }

  static void _backgroundFetch(SendPort sendPort) {
    // Set up a timer in the isolate to send a message every 8 seconds
    Timer.periodic(const Duration(seconds: 8), (timer) {
      sendPort.send(null); // Send a message to trigger data fetching in the main isolate
    });
  }

  @override
  void dispose() {
    _fetchingIsolate?.kill(priority: Isolate.immediate); // Terminate the isolate
    _receivePort?.close(); // Close the ReceivePort
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular TV Shows')),
      body: BlocBuilder<TvShowBloc, TvShowState>(
        builder: (context, state) {
          if (state is TvShowLoaded) {
            return ListView.builder(
              itemCount: state.tvShows.length + 1, // Extra item for loader
              itemBuilder: (context, index) {
                if (index < state.tvShows.length) {
                  final TvShowEntity tvShow = state.tvShows[index];
                  return ListTile(
                    leading: Image.network(
                      tvShow.imageThumbnailPath ??
                          "https://static.hbo.com/game-of-thrones-1-1920x1080.jpg",
                    ),
                    title: Text(tvShow.name ?? "Unknown Title"),
                    subtitle: Text(tvShow.network ?? "Unknown Network"),
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
          } else {
            return ListView.builder(
              itemCount: 15, // Placeholder items
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset("assets/godfther.jpg"),
                  title: const Text("Loading..."),
                  subtitle: const Text("Network"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
