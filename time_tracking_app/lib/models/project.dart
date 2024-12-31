class Project {
  final String id;
  final String name;
  const Project({required this.id, required this.name});
  factory Project.fromJson(Map<String, dynamic> jsonMap) {
    return Project(id: jsonMap['id'], name: jsonMap['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
