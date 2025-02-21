import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_video_player/models/video.dart';
import 'package:my_video_player/services/sql_helper.dart';
import 'package:my_video_player/services/video_finder.dart';

class VideoProvider extends ChangeNotifier {
  List<Video> _videos = [];
  List<Video> get videos => _videos;
  final VideoFinder _videoFinder = VideoFinder();
  final SqlHelper _sqlHelper = SqlHelper();
  VideoProvider() {
    loadVideos();
  }

  void loadVideos() async {
    _videos = await _videoFinder.findVideos();
    notifyListeners();
  }

  void refreshVideoCache() async {
    _videos = await _videoFinder.searchAgain();
    notifyListeners();
  }

  void deleteVideo(Video video) async {
    _sqlHelper.deleteVideo(video);
    _videos.removeWhere((e) => e.id == video.id);
    notifyListeners();
  }

  void renameVideo(Video oldVideoData, Video newVideoData) async {
    await _sqlHelper.updateVideo(newVideoData);
    _videos.updateWhere(newVideoData);
    File videoFile = File(oldVideoData.path);
    await videoFile.rename(newVideoData.path);
    notifyListeners();
  }
}

extension UpdateVideo on List {
  void updateWhere(Video video) {
    map((e) {
      if (e.id == video.id) {
        e = video;
      }
      return e;
    });
  }
}
