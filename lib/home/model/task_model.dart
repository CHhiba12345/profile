class Task {
  final String id;
  final String task;
  final bool completed;
  final String employeeId; // Add this line
  final String employeeIdInTask; // Add this line

  Task({
    required this.id,
    required this.task,
    required this.completed,
    required this.employeeId,
    required this.employeeIdInTask,
  });
}
