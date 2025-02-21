import 'package:flutter/material.dart';
import 'package:my_video_player/models/video.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget {
  final Video video;
  const PlayVideoPage({super.key, required this.video});

  @override
  State<PlayVideoPage> createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {
  late VideoPlayerController controller;
  @override
  void initState() {
    controller = VideoPlayerController.asset(widget.video.path);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(controller);
  }
}