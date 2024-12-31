class TagModel {
  final String tagName;
  final String id;

  const TagModel({required this.tagName, required this.id});
  factory TagModel.fromJson(Map<String, dynamic> tagMap){
    return TagModel(tagName: tagMap['tagName'], id: tagMap['id']);
  }
  Map<String, dynamic> toJson(){
    return {
'tagName':tagName,
'id':id,};
  }
}

