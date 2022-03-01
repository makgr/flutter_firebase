import 'dart:io';
import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firestore_services.dart';
import 'package:image_picker/image_picker.dart';

class AdNoteScreen extends StatefulWidget {
  User user;
  AdNoteScreen(this.user);
  @override
  _AdNoteScreenState createState() => _AdNoteScreenState();
}

class _AdNoteScreenState extends State<AdNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  File? imageFile;
  String? fileName;

Future<void> uploadImage()async{
  final picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if(pickedImage == null){
    return null;
  }
  setState(() {
    fileName = pickedImage.name;
    imageFile = File(pickedImage.path);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  height: 150,
                  child: imageFile == null ? Center(
                    child: Icon(Icons.image,size: 100,),
                    ):Center(
                      child: Image.file(imageFile!),
                    ),
                ),
              ),
              SizedBox(height: 20,),
              Text('Title',style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 20,),
              TextField(
                controller: titleController,
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
                controller: descriptionController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30,),
              loading ? Center(child: CircularProgressIndicator(),) : Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: ()async{
                    if(titleController.text == "" || descriptionController.text == "" || imageFile == null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
                    }else{
                      setState(() {
                        loading = true;
                      });
                      String imageUrl = await FirebaseStorage.instance.ref(fileName).putFile(imageFile!).then((result){
                        return result.ref.getDownloadURL();
                      });
                      print(imageUrl);
                      await FirestoreService().insertNote(titleController.text, descriptionController.text, imageUrl, widget.user.uid);
                      
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    }
                  },
                   child: Text('Add Note'),
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