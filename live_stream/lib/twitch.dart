import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TwitchStreamPlayer extends StatefulWidget {
  final String streamUrl;

  const TwitchStreamPlayer({super.key, required this.streamUrl});

  @override
  TwitchStreamPlayerState createState() => TwitchStreamPlayerState();
}

class TwitchStreamPlayerState extends State<TwitchStreamPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.streamUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Stream")),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
