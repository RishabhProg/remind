import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:remind/UI/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;

  User? get user => _user;

  String? _name;
  String? get name => _name;

  String?  _imgUrl;
  String? get imgUrl => _imgUrl;

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (googleUser == null) {
        return; 
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      await prefs.setString('UserName', user!.displayName.toString());
      await prefs.setString('ImgUrl', user!.photoURL.toString());
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => task()), // Replace with your screen widget
    );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();


    await prefs.remove('UserName');
        await prefs.remove('ImgUrl');
     


    notifyListeners();
  }
  
}
