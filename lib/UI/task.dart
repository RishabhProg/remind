import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/Authenticate.dart';
import 'package:remind/Models/task_Provider.dart';
import 'package:remind/UI/login.dart';

class task extends StatefulWidget {
  const task({super.key});

  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  @override
  void initState() {
    super.initState();
    // Fetch user data from SharedPreferences
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<taskProvider>(context, listen: false).getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<taskProvider>(context);
    final provider2 = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider.name != null && provider.imgUrl != null)
              Column(
                children: [
                  Text('User Name: ${provider.name}'),
                const  SizedBox(height: 20),
                  provider.imgUrl!.isNotEmpty
                      ? Image.network(provider.imgUrl!)
                      :const  Text('No image available'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        provider2.signOut();
                         Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => login_screen()), 
    );
                       
                      },
                      child: Text("Sign out"))
                ],
              )
            else
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
