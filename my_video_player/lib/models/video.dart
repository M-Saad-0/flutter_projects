class Video {
  final String id;
  final String path;
  final String name;

  Video({required this.id, required this.path, required this.name});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(id: json['id'], name: json['name'], path: json['path']);
  }

  Map<String, dynamic> toJson(){
    return{
      'id':id,'name':name,'path':path
    };
  }
}