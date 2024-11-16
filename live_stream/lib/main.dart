import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled3/twitch.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Live Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LiveYoutubeStreamScreen(),
                    ),
                  );
                },
                child: const Text("Youtube Stream")),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TwitchStreamPlayer(
                          streamUrl:
                              "https://www.youtube.com/watch?v=UBWmYZGhRbM"),
                    ),
                  );
                },
                child: const Text("Twitch Stream")),
          ],
        ),
      ),
    );
  }
}

class LiveYoutubeStreamScreen extends StatefulWidget {
  const LiveYoutubeStreamScreen({super.key});

  @override
  LiveYoutubeStreamScreenState createState() => LiveYoutubeStreamScreenState();
}

class LiveYoutubeStreamScreenState extends State<LiveYoutubeStreamScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: "NQqIW7QiZJc",
      flags: const YoutubePlayerFlags(
        isLive: true,
        autoPlay: true,
        showLiveFullscreenButton: true,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            log('Player is ready.');
          },
        ),
      ),
    );
  }
}
