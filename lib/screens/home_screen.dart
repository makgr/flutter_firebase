import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({ Key? key }) : super(key: key);

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
      
    );
  }
}