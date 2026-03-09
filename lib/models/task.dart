enum TaskQuadrant {
  urgentImportant,
  notUrgentImportant,
  urgentNotImportant,
  notUrgentNotImportant,
}

enum TaskPriority { p1, p2, p3 }

class Task {
  final String id;
  String title;
  String description;
  TaskQuadrant quadrant;
  TaskPriority priority;
  DateTime? deadline;
  bool isCompleted;
  bool isPinned;
  DateTime createdAt;
  DateTime? completedAt;
  List<String> tags;
  List<SubTask> subtasks;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.quadrant,
    this.priority = TaskPriority.p2,
    this.deadline,
    this.isCompleted = false,
    this.isPinned = false,
    required this.createdAt,
    this.completedAt,
    this.tags = const [],
    this.subtasks = const [],
  });

  double get completionPercent {
    if (subtasks.isEmpty) return isCompleted ? 1.0 : 0.0;
    final done = subtasks.where((s) => s.isDone).length;
    return done / subtasks.length;
  }
}

class SubTask {
  String title;
  bool isDone;

  SubTask({required this.title, this.isDone = false});
}
