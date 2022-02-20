
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class NoteModel {
  String id;
  String title;
  String description;
  Timestamp date;
  String userId;
  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.userId
  });
 
factory NoteModel.fromJson(DocumentSnapshot snapshot){
return NoteModel(
  id: snapshot.id, 
  title: snapshot['title'], 
  description: snapshot['description'], 
  date: snapshot['date'], 
  userId: snapshot['userId']
  );
}

  
}