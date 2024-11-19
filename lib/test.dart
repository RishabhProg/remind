// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ResponsiveBackground(),
//     );
//   }
// }

// class ResponsiveBackground extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration:const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/background.jpg'), 
//             fit: BoxFit.cover,
//           ),
//         ),
//         child:const Center(
//           child: Text(
//             'Responsive Background',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ////////////////////////////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:remind/Models/Authenticate.dart';
// import 'package:remind/Models/task_Provider.dart';
// import 'package:remind/UI/task.dart';
// import 'package:sign_in_button/sign_in_button.dart';

// class login_screen extends StatefulWidget {
//   const login_screen({super.key});

//   @override
//   State<login_screen> createState() => _login_screenState();
// }

// class _login_screenState extends State<login_screen> {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 50,
//           width: 300, 

          
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25), 
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: Offset(0, 3), 
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(25), 
//             child: SignInButton(
//               Buttons.google,
//               text: "Sign up with Google",
//               onPressed: () async {
//                 await authProvider.signInWithGoogle(context);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /////////////////////////

