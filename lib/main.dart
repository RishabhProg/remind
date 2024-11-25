import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/Authenticate.dart';
import 'package:remind/Models/task_Provider.dart';
import 'package:remind/Models/tasklist_Provider.dart';
import 'package:remind/UI/login.dart';
import 'package:remind/UI/task.dart';
import 'package:remind/firebase_options.dart';
import 'package:remind/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  
tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => taskProvider()),
        ChangeNotifierProvider(create: (context) => TasklistProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<taskProvider>(context);
    provider.getInfo();

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: provider.name==null? login_screen():task(),
    );
  }
}
