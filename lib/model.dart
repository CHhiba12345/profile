// model.dart
class UserProfile {
  List<String> information;
  List<String> education;
  List<String> skills;
  List<String> certifications;
  List<String> projects;
  List<String> languages;

  UserProfile({
    required this.information,
    required this.education,
    required this.skills,
    required this.certifications,
    required this.projects,
    required this.languages,
  });
}
class Task {
  final String id;
  final String task;
  final bool completed;
  final String employeeId;  // Add this line
  final String employeeIdInTask;  // Add this line

  Task({
    required this.id,
    required this.task,
    required this.completed,
    required this.employeeId,
    required this.employeeIdInTask,
  });
}


class Employee {
  final String id;
  final String firstName;
  final String lastName;
  final String position;
  final List<String> tasks;  // Liste d'IDs de tâches liées à cet employé

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.tasks,
  });
}


