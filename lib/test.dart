// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
// import 'package:remind/services/services.dart';

// DateTime scheduleTime = DateTime.now();

// class addTask extends StatefulWidget {
//   const addTask({super.key});

//   @override
//   State<addTask> createState() => _addTaskState();
// }

// class _addTaskState extends State<addTask> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [

            
            
            
//            TextButton(
//       onPressed: () {
//         DatePicker.showDateTimePicker(
//           context,
//           showTitleActions: true,
//           onChanged: (date) => scheduleTime = date,
//           onConfirm: (date) {},
//         );
//       },
//       child: const Text(
//         'Select Date Time',
//         style: TextStyle(color: Colors.blue),
//       ),
//     ), 
//    const SizedBox(height: 20,),
           
//            ElevatedButton(
//       child: const Text('Schedule notifications'),
//       onPressed: () {
//         debugPrint('Notification Scheduled for $scheduleTime');
//         NotificationService().scheduleNotification(
//             title: 'Scheduled Notification',
//             body: '$scheduleTime',
//             scheduledNotificationDateTime: scheduleTime);
//       },
//     )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert'; // For encoding and decoding JSON data
// class Task {
//   final String title;
//   final String description;
//   final String time;

//   Task({required this.title, required this.description, required this.time});

//   // Convert Task to Map for SharedPreferences
//   Map<String, String> toMap() {
//     return {'title': title, 'description': description, 'time': time};
//   }

//   // Create Task from Map
//   static Task fromMap(Map<String, dynamic> map) {
//     return Task(
//       title: map['title'],
//       description: map['description'],
//       time: map['time'],
//     );
//   }
// }

// class TaskManager extends StatefulWidget {
//   const TaskManager({super.key});

//   @override
//   State<TaskManager> createState() => _TaskManagerState();
// }

// class _TaskManagerState extends State<TaskManager> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   List<Task> tasks = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   // Load tasks from SharedPreferences
//   Future<void> _loadTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? tasksString = prefs.getString('tasks');
//     if (tasksString != null) {
//       final List<dynamic> taskList = jsonDecode(tasksString);
//       tasks = taskList.map((taskMap) => Task.fromMap(taskMap)).toList();
//     }
//     setState(() {});
//   }

//   // Save tasks to SharedPreferences
//   Future<void> _saveTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<Map<String, String>> taskList = tasks.map((task) => task.toMap()).toList();
//     await prefs.setString('tasks', jsonEncode(taskList));
//   }

//   // Add a new task
//   void _addTask() {
//     if (titleController.text.trim().isEmpty ||
//         descriptionController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill in both fields!'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     final newTask = Task(
//       title: titleController.text.trim(),
//       description: descriptionController.text.trim(),
//       time: DateTime.now().toString(),
//     );
//     setState(() {
//       tasks.add(newTask);
//     });
//     _saveTasks();
//     titleController.clear();
//     descriptionController.clear();
//   }

//   // Delete a task
//   void _deleteTask(int index) {
//     setState(() {
//       tasks.removeAt(index);
//     });
//     _saveTasks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Task Manager'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: titleController,
//                   decoration: const InputDecoration(
//                     labelText: 'Task Title',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(
//                     labelText: 'Task Description',
//                     border: OutlineInputBorder(),
//                   ),
//                   maxLines: 2,
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _addTask,
//                   child: const Text('Add Task'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: tasks.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'No tasks yet. Add a task!',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: tasks.length,
//                     itemBuilder: (context, index) {
//                       final task = tasks[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 4,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: ListTile(
//                             title: Text(task.title),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(task.description),
//                                 Text(
//                                   'Time: ${task.time}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () => _deleteTask(index),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// ///////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'task_provider.dart';
// import 'task_model.dart';

// class TaskManager extends StatelessWidget {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   TaskManager({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<TaskProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Task Manager'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: titleController,
//                   decoration: const InputDecoration(
//                     labelText: 'Task Title',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: descriptionController,
//                   decoration: const InputDecoration(
//                     labelText: 'Task Description',
//                     border: OutlineInputBorder(),
//                   ),
//                   maxLines: 2,
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (titleController.text.trim().isEmpty ||
//                         descriptionController.text.trim().isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please fill in both fields!'),
//                           duration: Duration(seconds: 2),
//                         ),
//                       );
//                       return;
//                     }

//                     final newTask = Task(
//                       title: titleController.text.trim(),
//                       description: descriptionController.text.trim(),
//                       time: DateTime.now().toString(),
//                     );
//                     taskProvider.addTask(newTask);

//                     titleController.clear();
//                     descriptionController.clear();
//                   },
//                   child: const Text('Add Task'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: taskProvider.tasks.isEmpty
//                 ? const Center(
//                     child: Text(
//                       'No tasks yet. Add a task!',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: taskProvider.tasks.length,
//                     itemBuilder: (context, index) {
//                       final task = taskProvider.tasks[index];
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 4,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: ListTile(
//                             title: Text(task.title),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(task.description),
//                                 Text(
//                                   'Time: ${task.time}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () => taskProvider.deleteTask(index),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
