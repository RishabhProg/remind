// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'auth_provider.dart';

// class AuthPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text("Google Sign-In")),
//       body: Center(
//         child: authProvider.user == null
//             ? ElevatedButton(
//                 onPressed: () async {
//                   await authProvider.signInWithGoogle();
//                 },
//                 child: Text("Sign in with Google"),
//               )
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Signed in as: ${authProvider.user?.displayName}"),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await authProvider.signOut();
//                     },
//                     child: Text("Sign Out"),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
