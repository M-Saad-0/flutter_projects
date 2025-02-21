import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_video_player/models/video.dart';
import 'package:my_video_player/services/sql_helper.dart';

class VideoFinder {
  static final VideoFinder _instance = VideoFinder._internal();
  final SqlHelper _sqlHelper = SqlHelper();
  VideoFinder._internal();
  factory VideoFinder() {
    return _instance;
  }

  Future<List<Video>> findVideos() async {
    List<Video> vids = await _sqlHelper.getVideos();
    if (vids.isNotEmpty) {
      return [];
    }
    Directory dir = Directory("/storage/emulated/0/");
    List<String> restrictedPaths = [
    "/storage/emulated/0/Android",
    "/storage/emulated/0/LOST.DIR",
    "/storage/emulated/0/.thumbnails",
    "/storage/emulated/0/.Trash",
  ];
  var allFolder =  dir.listSync();
  allFolder.removeWhere((e)=>e.path.contains("/storage/emulated/0/Android"));

    var fsEntity = [];
    for(var d in allFolder){
    Directory dir = Directory(d.path);

     dir.listSync(recursive: true).where((e) {
      
      debugPrint(e.path);
      return (e.path.endsWith('.mp4') ||
        e.path.endsWith('.mkv') ||
        e.path.endsWith('.avi'));
    });
    if (fsEntity.isEmpty) {
      return [];
    }}
    return fsEntity
        .map((e) {
          String timeStamp = DateTime.timestamp().toIso8601String();
          Video videoObject = Video(
            id: timeStamp,
            path: e.path,
            name: e.path.split('/').last);
          _sqlHelper.insertVideo(videoObject);
          return videoObject;
        })
        .toList();
  }

  Future<List<Video>> searchAgain()async{
    _sqlHelper.deleteAll();
    Directory dir = Directory("/storage/emulated/0/");
    var fsEntity = dir.listSync().where((e) => (e.path.endsWith('.mp4') ||
        e.path.endsWith('.mkv') ||
        e.path.endsWith('.avi')));
    if (fsEntity.isEmpty) {
      return [];
    }
    return fsEntity
        .map((e) {
          String timeStamp = DateTime.timestamp().toIso8601String();
          Video videoObject = Video(
            id: timeStamp,
            path: e.path,
            name: e.path.split('/').last);
          _sqlHelper.insertVideo(videoObject);
          return videoObject;
        })
        .toList();
  }
}
