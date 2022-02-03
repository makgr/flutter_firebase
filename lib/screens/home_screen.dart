import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
        actions: [
          TextButton.icon(onPressed: (){}, icon: Icon(Icons.logout), label: Text('Sign Out')),
        ],
      ),
      
    );
  }
}