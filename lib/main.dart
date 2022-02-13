import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/screens/register_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: FirebaseOptions(
      apiKey: "AIzaSyCSzr4ALpFKanlnk_WPwBbSjBZmj5QzEUw", 
      appId: "1:65800948821:android:0ecc56c7eca851719e58dc", 
      messagingSenderId: "65800948821", 
      projectId: "flutterfirebase-d8b7e",
      authDomain: "flutterfirebase-d8b7e.firebaseapp.com"
      )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: authService().firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Homescreen();
          }
          return Homescreen();
        }
      ),
    );
  }
}

