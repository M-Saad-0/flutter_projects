import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_video_player/providers/video_provider.dart';
import 'package:my_video_player/widgets/video_block.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.video_collection_rounded),
        title: const Text("Play Videos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<VideoProvider>(
          builder: (context, provider, child) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: provider.videos.length,
            itemBuilder: (context, index) =>
                VideoBlock(video: provider.videos[index]),
          ),
        ),
      ),
    );
  }
}
