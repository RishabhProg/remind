
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/Authenticate.dart';
import 'package:remind/Models/task_Provider.dart';
import 'package:remind/UI/task.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authProvider.signInWithGoogle(context);
           
          },
          child: const Text("Sign in with Google"),
        ),
      ),
    );
  }
}
