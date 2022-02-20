import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  // const AdNoteScreen({ Key? key }) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              Text('Description',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              TextField(
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: (){},
                   child: Text('Update Note'),
                   style: ElevatedButton.styleFrom(primary: Colors.orange),
                   ),
              ),
            ],
          ),
          ),
        ),
    );
  }
}