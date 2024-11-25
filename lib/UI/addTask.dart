import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
        "convince me to do this task (${title}) using it's description  (${description}).Reply in 40 words.)";
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 200,
                  width: 200,
                   child: LottieBuilder.asset(
                      "assets/watch.json",
                      repeat: true,
                      
                      fit: BoxFit.contain,
                    ),
                 ),
                 const SizedBox(height: 30,),
                TextField(
  controller: titleController,
  decoration: InputDecoration(
    labelText: 'Task Title',
    labelStyle:GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 20, 19),
                        letterSpacing: .5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // Make the border rounder
      borderSide: const BorderSide(
        color: Colors.grey, // Set the border color
        width: 2.0,         // Set the border width
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.grey, // Border color for the enabled state
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.blue, // Border color when focused
        width: 2.0,
      ),
    ),
  ),
),

                const SizedBox(height: 20),
                TextField(
  controller: descriptionController,
  decoration: InputDecoration(
    labelText: 'Task Description',
    labelStyle:GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 20, 19),
                        letterSpacing: .5,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0), // Make the border rounder
      borderSide: const BorderSide(
        color: Colors.grey, // Set the border color
        width: 2.0,         // Set the border width
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.grey, // Border color for the enabled state
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: Colors.blue, // Border color when focused
        width: 2.0,
      ),
    ),
  ),
  maxLines: 3, // Allows for a multi-line input
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
                  child:  Text(
                    'Select Date Time',
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 35, 100, 179),
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                  child:  Text('Schedule Notifications',style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 20, 19),
                        letterSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
