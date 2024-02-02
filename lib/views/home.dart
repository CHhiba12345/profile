import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controller.dart';
import 'package:profile/model.dart';
import 'profile.dart';

class HomeController extends StatefulWidget {
  final String email;

  HomeController({required this.email});

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  final UserController _userController = UserController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Task> tasks = [];
  List<Employee> employees = [];

  Future<void> _markTaskAsCompleted(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).update({'completed': true});
    _loadTasks();
  }

  void _showCompletionMessage(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const  Text('Good Job!'),
          content: Column(
            children: [
              const Text('You completed the task successfully.'),
              if (widget.email != 'chaoualihiba25@gmail.com') // Afficher le commentaire seulement pour l'utilisateur
                const SizedBox(height: 10),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

/// fucnction for delete task
  /// description
  void _deleteEmployee(String employeeId) {
    _firestore.collection('employees').doc(employeeId).delete().then((_) {
      _loadEmployees();
    });
  }

  /// ++++++++++++++++++++++++++++++++
  /// fuction for fetch all task from task collection
  /// and will return list of type task
  /// hne tawika elmochkl lehne ak ey
  /// **************************************
  Future<void> _loadTasksFromFirebase() async {
    final   querySnapshot = await _firestore.collection('tasks').get() ;
    print("get all query from snapshot ${querySnapshot.docs}"); //code fel git hub t3k wela just fel pc fel pc st3mlt git wela nn ey sta3melt amaa 7atit fih chtar l5edma bark lparty hethi mazedthech
    setState(() {
      tasks = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Task(
          id: doc.id,
          task: data['task'],
          completed: data['completed'] ?? false,
          employeeId: data['employeeId'] ?? '', // Ajout de l'ID de l'employé lié à la tâche
          employeeIdInTask: data['employeeIdInTask'] ?? '',
        );
      }).toList();
    });
  }

  /// ++++++++++++++++++++++++++++++++++++++++++++++
  /// admin create task for an employe
  /// and send them to collection Tasks
  /// *******************************************
  Future<void> _addNewTask(String task, String employeeId) async {
    // Ajouter une nouvelle tâche
    final DocumentReference taskRef = await _firestore.collection('tasks').add({
      'task': task,
      'completed': false,
      'employeeIdInTask': employeeId,
    });

    // Mettre à jour la liste des tâches de l'employé avec l'ID de la nouvelle tâche
    await _firestore.collection('employees').doc(employeeId).update({
      'tasks': FieldValue.arrayUnion([taskRef.id]),
    });

    _loadTasksFromFirebase();
  }

  void _showTaskInputDialog(BuildContext context, Employee employee) {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une Tâche pour ${employee.firstName} ${employee.lastName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Tâche'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _addNewTask(taskController.text, employee.id);
                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadEmployees();
  }

  Future<void> _loadTasks() async {
    final QuerySnapshot querySnapshot = await _firestore.collection('tasks').get();
    setState(() {
      tasks = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Task(
          id: doc.id,
          task: data['task'],
          completed: data['completed'] ?? false,
          employeeId: data['employeeId'] ?? '',
          employeeIdInTask: data['employeeIdInTask'] ?? '',
        );
      }).toList();
    });
  }

  void _loadEmployees() {
    _firestore.collection('employees').get().then((QuerySnapshot snapshot) {
      setState(() {
        employees = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Employee(
            id: doc.id,
            firstName: data['firstName'],
            lastName: data['lastName'],
            position: data['position'],
            tasks: List<String>.from(data['tasks'] ?? []),
          );
        }).toList();
      });
    });
  }

  void _editTask(String taskId, String updatedTask) async {
    await _firestore.collection('tasks').doc(taskId).update({'task': updatedTask});
    _loadTasksFromFirebase();
  }

  void _deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
    _loadTasksFromFirebase();
  }

  Widget _buildEmployeeCard(Employee employee) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_picture.jpeg'),
            ),
            SizedBox(height: 20),
            Text(
              '${employee.firstName} ${employee.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              employee.position,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(userController: _userController),
                  ),
                );
              },
              child: Text('Voir le Profil'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showTasksListDialog(context, employee);
              },
              child: Text('Liste des Tâches'),
            ),
            if (widget.email == 'chaoualihiba25@gmail.com')
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _deleteEmployee(employee.id);
                    },
                    child: Text('Supprimer Employé'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showTasksListDialog(BuildContext context, Employee employee) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Liste des Tâches de ${employee.firstName} ${employee.lastName}'),
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(tasks[index].task),
                  subtitle: tasks[index].completed ? Text('Terminé') : Text('En cours'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!tasks[index].completed && widget.email != 'chaoualihiba25@gmail.com')
                        ElevatedButton(
                          onPressed: () {
                            _markTaskAsCompleted(tasks[index].id);
                            _showCompletionMessage(context, tasks[index].id);
                          },
                          child: Text('Terminer'),
                        ),
                      if (widget.email == 'chaoualihiba25@gmail.com')
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditTaskDialog(context, tasks[index]);
                          },
                        ),
                      if (widget.email == 'chaoualihiba25@gmail.com')
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteTaskDialog(context, tasks[index].id);
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            if (widget.email == 'chaoualihiba25@gmail.com')
              ElevatedButton(
                onPressed: () {
                  _showTaskInputDialog(context, employee);
                },
                child: Text('Ajouter Tâche'),
              ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    TextEditingController editTaskController = TextEditingController(text: task.task);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier Tâche'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTaskController,
                decoration: InputDecoration(labelText: 'Tâche'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _editTask(task.id, editTaskController.text);
                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteTaskDialog(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer Tâche'),
          content: Text('Êtes-vous sûr de vouloir supprimer cette tâche ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _deleteTask(taskId);
                Navigator.pop(context);
              },
              child: Text('Supprimer'),
            ),
          ],
        );
      },
    );
  }

  void _showAddEmployeeDialog(BuildContext context) {
    String firstName = '';
    String lastName = '';
    String position = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un Employé'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  firstName = value;
                },
                decoration: InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                onChanged: (value) {
                  lastName = value;
                },
                decoration: InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                onChanged: (value) {
                  position = value;
                },
                decoration: InputDecoration(labelText: 'Poste'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _addNewEmployee(firstName, lastName, position);
                Navigator.pop(context);
              },
              child: Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  void _addNewEmployee(String firstName, String lastName, String position) {
    _firestore.collection('employees').add({
      'firstName': firstName,
      'lastName': lastName,
      'position': position,
      'tasks': [],
    }).then((_) {
      _loadEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          if (widget.email == 'chaoualihiba25@gmail.com')
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                _showAddEmployeeDialog(context);
              },
            ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/welcome_image.jpeg',
            fit: BoxFit.cover,
          ),
          if (employees.isNotEmpty)
            ListView(
              children: employees.map((employee) => _buildEmployeeCard(employee)).toList(),
            ),
        ],
      ),
    );
  }
}