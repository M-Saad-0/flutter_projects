class TimeEntry {
  final String id;
  final String projectId;
  final String taskId;
  final String notes;
  final double totalTime;
  final DateTime date;

  TimeEntry({
    required this.id,
    required this.projectId,
    required this.taskId,
    required this.notes,
    required this.totalTime,
    required this.date,
  });

  factory TimeEntry.fromJson(Map<String, dynamic> jsonMap) {
    return TimeEntry(
      id: jsonMap['id'] as String, 
      projectId: jsonMap['projectId'] as String, 
      taskId: jsonMap['taskId'] as String, 
      notes: jsonMap['notes'] as String, 
      totalTime: jsonMap['totalTime'] as double, 
      date: DateTime.parse(jsonMap['date'] as String), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'taskId': taskId,
      'notes': notes,
      'totalTime': totalTime,
      'date': date.toString(), 
    };
  }
}