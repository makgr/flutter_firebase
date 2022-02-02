import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class authService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> register(String email, String password)async{
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch (e) {
      SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,);
    }catch (e){
      print(e);
    }
  }

  Future<User?> login(String email, String password)async{
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch (e) {
      SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,);
    }catch (e){
      print(e);
    }
  }

}