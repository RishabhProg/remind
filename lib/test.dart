// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:remind/Models/Authenticate.dart';
// import 'package:remind/Models/task_Provider.dart';
// import 'package:remind/UI/login.dart';

// class task extends StatefulWidget {
//   const task({super.key});

//   @override
//   State<task> createState() => _taskState();
// }

// class _taskState extends State<task> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<taskProvider>(context, listen: false).getInfo();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<taskProvider>(context);
//     final provider2 = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (provider.name != null && provider.imgUrl != null)
//               Column(
//                 children: [
//                   Text('User Name: ${provider.name}'),
//                 const  SizedBox(height: 20),
//                   provider.imgUrl!.isNotEmpty
//                       ? Image.network(provider.imgUrl!)
//                       :const  Text('No image available'),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                       onPressed: () {
//                         provider2.signOut();
//                          Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => login_screen()), 
//     );
   
//                       },
//                       child: Text("Sign out"))
//                 ],
//               )
//             else
//               const CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/Authenticate.dart';
import 'package:remind/Models/task_Provider.dart';
import 'package:remind/UI/login.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
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

    return Scaffold(
      body: Column(
        children: [
          // Custom AppBar with curved corners and shadow
          Container(
            height: 120, // Adjust height as needed
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/appbar_bg.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16), // Curved corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  offset: const Offset(0, 4), // Shadow position
                  blurRadius: 10, // Spread of shadow
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User's Circular Avatar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: provider.imgUrl != null && provider.imgUrl!.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(provider.imgUrl!),
                            radius: 24,
                          )
                        : const CircleAvatar(
                            child: Icon(Icons.person),
                            radius: 24,
                          ),
                  ),
                  // Title in the Center
                  const Text(
                    'Tasks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white, // Adjust color based on background
                    ),
                  ),
                  // Menu Button on the Right
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Sign Out') {
                        provider2.signOut();
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
                      color: Colors.white, // Adjust color based on background
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rest of the UI
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (provider.name != null && provider.imgUrl != null)
                    Column(
                      children: [
                        Text('User Name: ${provider.name}'),
                        const SizedBox(height: 20),
                        provider.imgUrl!.isNotEmpty
                            ? Image.network(provider.imgUrl!)
                            : const Text('No image available'),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            provider2.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const login_screen(),
                              ),
                            );
                          },
                          child: const Text("Sign out"),
                        ),
                      ],
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}