class Employee {
  final String id;
  final String firstName;
  final String lastName;
  final String position;
  final List<String> tasks; // Liste d'IDs de tâches liées à cet employé
  final List<String>
      task_employee; // Nouvelle liste pour les tâches spécifiques à cet employé
  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.tasks,
    required this.task_employee,
  });
}
