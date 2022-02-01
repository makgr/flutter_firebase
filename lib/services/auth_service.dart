import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class authService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> register(String email, String password)async{
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
   return userCredential.user;
  }

  Future<User?> login(String email, String password)async{
    UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
   return userCredential.user;
  }

}