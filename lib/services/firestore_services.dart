
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String title, String description,String userId) async{
    try {
      await firestore.collection('notes').add({
        "title": title,
        "description": description,
        "date": DateTime.now(),
        "userId" : userId 
      });
    } catch (e) {

    }
  }
}