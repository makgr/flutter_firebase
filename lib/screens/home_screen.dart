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
                // await users.add({
                //   'name':'Khan'
                // });
                await users.doc('flutter123').set({
                  'name': "google flutter"
                });
              }, 
              child: Text('Add data to firestore'),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()async{
                CollectionReference users = firestore.collection('users');
                // QuerySnapshot allResult = await users.get();
                // allResult.docs.forEach((DocumentSnapshot result) { 
                //   print(result.data());
                // });
                // DocumentSnapshot result = await users.doc('flutter123').get();
                // print(result.data());
                users.doc('flutter123').snapshots().listen((result) { 
                  print(result.data());
                });
              },
               child: Text('Read Data from firestore'),
               ),
               SizedBox(height: 20,),
               ElevatedButton(
                 onPressed: ()async{
                   await firestore.collection('users').doc('flutter123').update({
                     'name' : 'flutter firebase'
                   });
                 }, 
                 child: Text('Update data'),
                 ),
                 SizedBox(height: 20,),
               ElevatedButton(
                 onPressed: ()async{
                   await firestore.collection('users').doc('flutter123').delete();
                 }, 
                 child: Text('Delete data'),
                 ),
          ],
        ),
      ),
      
    );
  }
}