class Task {
  final String id;
  final String name;
  const Task({required this.id, required this.name});
  factory Task.fromJson(Map<String, dynamic> jsonMap) {
    return Task(id: jsonMap['id'], name: jsonMap['name']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
