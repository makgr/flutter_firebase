import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/note.dart';
import 'package:flutter_firebase/screens/add_note.dart';
import 'package:flutter_firebase/screens/edit_note.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class Homescreen extends StatelessWidget {
  User user;
  Homescreen(this.user);
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').where('userId', isEqualTo: user.uid).snapshots(),
        builder: (contex, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length > 0){
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (contex,index){
                  NoteModel note = NoteModel.fromJson(snapshot.data.docs[index]);
                  return Card(
                        color: Colors.teal,
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          title: Text(note.title.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          subtitle: Text(note.description.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,),
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNoteScreen(note)));
                          },
                        ),
                      );
                 }
                );
            }else{
              return Center(child: Text('No Notes available'),);
            }
          }
          return Center(child: CircularProgressIndicator(),);
        }
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdNoteScreen(user)));
        },
        backgroundColor: Colors.orangeAccent,
      ),
      
    );
  }
}