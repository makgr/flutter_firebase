import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/add_note.dart';
import 'package:flutter_firebase/screens/edit_note.dart';
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
      body: ListView(
        children: [
          Card(
            color: Colors.teal,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              title: Text('Build a new app',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              subtitle: Text('Learn to build',overflow: TextOverflow.ellipsis,maxLines: 2,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNoteScreen()));
            },
                
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdNoteScreen()));
        },
        backgroundColor: Colors.orangeAccent,
      ),
      
    );
  }
}