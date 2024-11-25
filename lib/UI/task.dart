import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/Authenticate.dart';
import 'package:remind/Models/task_Provider.dart';
import 'package:remind/Models/tasklist_Provider.dart';
import 'package:remind/UI/addTask.dart';
import 'package:remind/UI/login.dart';
import 'package:remind/services/services.dart';
//import 'package:remind/services/gemini.dart';

class task extends StatefulWidget {
  const task({super.key});

  @override
  State<task> createState() => _TaskState();
}

class _TaskState extends State<task> {
  // GeminiApi geminiApi = GeminiApi();
  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<taskProvider>(context, listen: false).getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<taskProvider>(context);
    final provider2 = Provider.of<AuthProvider>(context);
    final provider3 = Provider.of<TasklistProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/back.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)), 
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 4), 
                  blurRadius: 10, 
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        provider.imgUrl != null && provider.imgUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(provider.imgUrl!),
                                radius: 24,
                              )
                            : const CircleAvatar(
                                child: Icon(Icons.person),
                                radius: 24,
                              ),
                  ),
                  Text(
                    '${provider.name}',
                    style: GoogleFonts.lilitaOne(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 19, 20, 19),
                        letterSpacing: .5,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Sign Out') {
                        provider2.signOut(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login_screen()),
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'Sign Out',
                        child: Text('Sign Out'),
                      ),
                    ],
                    icon: const Icon(
                      Icons.more_vert,
                      color: Color.fromARGB(255, 31, 29, 29),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider3.tasks.length,
              itemBuilder: (context, index) {
                final task = provider3.tasks[index];
                //final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text(
                                task.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                             
                              Text(
                                task.time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        
                        IconButton(
                             icon: const Icon(Icons.delete, color: Color.fromARGB(255, 50, 153, 200)),
                                 onPressed: () {
                                   final taskId = task.listid;
                                  provider3.deleteTask(index); 
                                    notificationService.cancelNotification(taskId); 
                                   ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                     content: Text('Task "${task.title}" deleted successfully!'),
                                     duration: Duration(seconds: 2),
                                     ),
                                         );
                                               },
                                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const addTask()),
                );
              },
              child: const Text(
                "Add +",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
