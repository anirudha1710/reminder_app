class ReminderModel {
  final String id;
  final String title;
  final String description;
  final DateTime time;
  final String priority;

  ReminderModel({required this.id, required this.title, required this.description, required this.time, required this.priority});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
      'priority': priority,
    };
  }

  static ReminderModel fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      time: DateTime.parse(map['time']),
      priority: map['priority'],
    );
  }
}