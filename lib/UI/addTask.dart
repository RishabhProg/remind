import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/tasklist_Provider.dart';
import 'package:remind/services/gemini.dart';
import 'package:remind/services/services.dart';
import 'package:remind/services/taskList.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime scheduleTime = DateTime.now();

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  State<addTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<addTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? Listtitle;
  String? Listdate;
  int? Listid;

  GeminiApi geminiApi = GeminiApi();

  void scheduleNotification() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    
    int id = sharedPreferences.getInt('notification_id') ?? 0;
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    Listtitle = title;
    Listdate = scheduleTime.toString();
    geminiApi.res =
        "convince me to (${title}) using my about this task which are (${description} in 40 words.)";
    String generatedText = await geminiApi.geminiTxt();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both the title and description!'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
   // Listid = id;
    print(id);
    debugPrint('Notification Scheduled for $scheduleTime');
    NotificationService().scheduleNotification(
      id: id,
      title: title,
      body: generatedText,
      scheduledNotificationDateTime: scheduleTime,
    );
    id++;
    await sharedPreferences.setInt('notification_id', id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification Scheduled Successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TasklistProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Task Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(
                    context,
                    showTitleActions: true,
                    onChanged: (date) => scheduleTime = date,
                    onConfirm: (date) => {},
                  );
                },
                child: const Text(
                  'Select Date Time',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                  scheduleNotification();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

   
    Listid = sharedPreferences.getInt('notification_id') ?? 0;
                  final newTask = Task(
                    title:titleController.text.trim(),
                    listid: Listid!,
                    time: scheduleTime.toString(),
                  );
                   taskProvider.addTask(newTask);
                  
                },
                child: const Text('Schedule Notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
