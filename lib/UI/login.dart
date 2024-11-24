
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:remind/Models/Authenticate.dart';
// import 'package:remind/Models/task_Provider.dart';
// import 'package:remind/UI/task.dart';
import 'package:sign_in_button/sign_in_button.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});
  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
           constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration:const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/back.jpg'), 
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children:[
               SizedBox(height: Height*0.05,),
             Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                  'Remind',
                  style: GoogleFonts.lilitaOne(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 19, 20, 19),
            letterSpacing: .5,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
                  ),
            ),
            const SizedBox(width: 10),
            Image.asset(
                  'assets/bell.png',
                  height: 35,
                  width: 35,
            ),
          ],
                  ),
                   SizedBox(height: Height*0.07,),
                  
                  
          
           Padding(
             padding: const EdgeInsets.only(right: 200),
             child: Text(
          'Welcome!',
          style: GoogleFonts.comfortaa(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 19, 20, 19),
              letterSpacing: .5,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
                  ),
           ),
                   SizedBox(height: Height*0.01,),
                  
                  
                  
          
           Padding(
             padding:  EdgeInsets.only(right:Width*0.01 ,left:Width*0.01  ),
             child: Text(
                  'Enhance your productivity\nwith Remind and get things\ndone on time.',
                   style: GoogleFonts.comfortaa(
                  textStyle:  TextStyle(
          color: Color.fromARGB(255, 19, 20, 19),
          letterSpacing: .5,
          fontSize: Width*0.057,
          fontWeight: FontWeight.w300,
                  ),
                   ),
             ),
           ),
             SizedBox(height: Height*0.02,),
            
                  
                   LottieBuilder.asset(
                  "assets/meditate.json",
                  repeat: true,
                  
                  fit: BoxFit.contain,
                ),
                  SizedBox(height: Height*0.03,),
              
              Container(
                          height: 50,
                          width: 300, 
                  
                          
                          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), 
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), 
                ),
              ],
                          ),
                          child: ClipRRect(
              borderRadius: BorderRadius.circular(25), 
              child: SignInButton(
                Buttons.google,
                text: "Sign up with Google",
                onPressed: () async {
                  await authProvider.signInWithGoogle(context);
                },
              ),
                          ),
                        ),
         
          
          ]
          ),
        ),
      ),
    );
  }
}

/////////////////////////
