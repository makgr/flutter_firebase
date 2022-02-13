import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class Homescreen extends StatelessWidget {

 FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
        actions: [
          TextButton.icon(onPressed: ()async{
            await authService().signOut();
          }, icon: Icon(Icons.logout), label: Text('Sign Out')),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ()async{
                CollectionReference users = firestore.collection('users');
                await users.add({
                  'name':'Khan'
                });
              }, 
              child: Text('Add data to firestore'),
              )
          ],
        ),
      ),
      
    );
  }
}