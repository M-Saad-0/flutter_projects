import 'package:my_video_player/models/video.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static final SqlHelper _instance = SqlHelper._internal();
  SqlHelper._internal();
  factory SqlHelper() {
    return _instance;
  }

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_video.app');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE Video (id TEXT PRIMARY KEY, name TEXT, path TEXT)");
  }

  Future<void> insertVideo(Video video) async {
    final db = await database;
    await db.insert('Video', video.toJson());
  }

  Future<void> deleteVideo(Video video) async {
    final db = await database;
    db.delete('Video', where: 'id = ?', whereArgs: [video.id]);
  }

  Future<List<Video>> getVideos() async {
    final db = await database;
    List<Map<String, Object?>> videos =
        await db.rawQuery("SELECT * FROM Video");
    if (videos.isEmpty) {
      return [];
    }
    return videos.toVideos();
  }

  Future<void> updateVideo(Video video) async {
    final db = await database;
    await db.update("Video", video.toJson(),
        where: 'id = ?', whereArgs: [video.id]);
  }

  Future<void> deleteAll()async{
    final db = await database;
    await db.delete("Video");
  }
}

extension ChangeToVideos on List {
  List<Video> toVideos() {
    return map((e) {
      return Video.fromJson(e);
    }).toList();
  }
}
