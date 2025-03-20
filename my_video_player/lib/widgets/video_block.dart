import 'package:flutter/material.dart';
import 'package:my_video_player/models/video.dart';
import 'package:my_video_player/pages/play_video_page.dart';

class VideoBlock extends StatelessWidget {
  final Video video;
  const VideoBlock({super.key, required this.video});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayVideoPage(video: video)));
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.video_collection_outlined,
                size: 70,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(video.name, textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
