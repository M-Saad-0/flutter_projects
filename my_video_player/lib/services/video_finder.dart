import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_video_player/models/video.dart';
import 'package:my_video_player/services/sql_helper.dart';
import 'package:my_video_player/widgets/toast_message.dart';

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
      return vids;
    }
    Directory dir = Directory("/storage/emulated/0/");
    var allFolder = dir.listSync();
    print("*********Folders*********");
    print(allFolder);
    allFolder.removeWhere((e)=>e.path=="/storage/emulated/0/Android");
    allFolder.removeWhere((e)=>e.path.startsWith("/storage/emulated/0/."));
    allFolder.add(Directory("/storage/emulated/0/Android/media"));
    List<FileSystemEntity> fsEntity = [];
    for (FileSystemEntity d in allFolder) {
      Directory dir = Directory(d.path);

      fsEntity.addAll(dir.listSync(recursive: true).where((e) {
        toastMessage("Looking in ${d.path}");
        // debugPrint(e.path);
        return (e.path.endsWith('.mp4') ||
            e.path.endsWith('.mkv') ||
            e.path.endsWith('.avi'));
      }).toList());
      
    }
    print("fsEntity$fsEntity");
    return fsEntity.map<Video>((e) {
      String timeStamp = DateTime.timestamp().toIso8601String();
      Video videoObject =
          Video(id: timeStamp, path: e.path, name: e.path.split('/').last);
      _sqlHelper.insertVideo(videoObject);
      return videoObject;
    }).toList();
  }

  Future<List<Video>> searchAgain() async {
    _sqlHelper.deleteAll();
    Directory dir = Directory("/storage/emulated/0/");
    var fsEntity = dir.listSync().where((e) => (e.path.endsWith('.mp4') ||
        e.path.endsWith('.mkv') ||
        e.path.endsWith('.avi')));
    if (fsEntity.isEmpty) {
      return [];
    }
    return fsEntity.map((e) {
      String timeStamp = DateTime.timestamp().toIso8601String();
      Video videoObject =
          Video(id: timeStamp, path: e.path, name: e.path.split('/').last);
      _sqlHelper.insertVideo(videoObject);
      return videoObject;
    }).toList();
  }
}
