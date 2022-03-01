
import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({ Key? key }) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  bool loading = false;

Future<void> uploadImage(String inputSource)async{
  final picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: inputSource == 'camera' ? ImageSource.camera : ImageSource.gallery);
  if(pickedImage == null){
    return null;
  }
  String fileName = pickedImage.name;
  File imageFile = File(pickedImage.path);
  File compressFile = await compressImage(imageFile);
 try {
   setState(() {
     loading = true;
   });
   await firebaseStorage.ref(fileName).putFile(compressFile);
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully uploaded.'),backgroundColor: Colors.green,));
 }on FirebaseAuthException catch (e) {
   print(e);
 }catch(error){
   print(error);
 }

}

Future<void> uploadMultipleImages()async{
  final picker = ImagePicker();
  final List<XFile>? pickedImages = await picker.pickMultiImage();
  if(pickedImages == null){
    return null;
  }
  setState(() {
    loading = true;
  });
  await Future.forEach(pickedImages, (XFile image)async{
    String fileName = image.name;
    File imageFile = File(image.path);
    try {
      await firebaseStorage.ref(fileName).putFile(imageFile);
    }on FirebaseException catch (e) {
      print(e);
    }
  });
  setState(() {
    loading = false;
  });
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All Images uploaded successfully.'),backgroundColor: Colors.green,));
}

Future<List> loadImages()async{
 List<Map> files = [];
 final ListResult result = await firebaseStorage.ref().listAll();
 final List<Reference> allFiles = result.items;
 await Future.forEach(allFiles, (Reference file)async{
   final String fileUrl = await file.getDownloadURL();
   files.add({
     "url": fileUrl,
     "path": file.fullPath
   });
 });
 return files;
}

Future deleteImage(String ref)async{
 await firebaseStorage.ref(ref).delete();
 setState(() {
   
 });
}

Future compressImage(File file)async{
 File compressFile = await FlutterNativeImage.compressImage(file.path,quality: 50);
 return compressFile;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload image to storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            loading? Center(child: CircularProgressIndicator(),): Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: (){
                  uploadImage('camera');
                }, icon: Icon(Icons.camera), label: Text('Camera')),
                ElevatedButton.icon(onPressed: (){
                  uploadImage('gallery');
                }, icon: Icon(Icons.library_add), label: Text('Gallery')),
              ],
            ),
            SizedBox(height: 30,),
            ElevatedButton.icon(onPressed: (){
              uploadMultipleImages();
            }, 
            icon: Icon(Icons.image),
            label: Text('Multiple Images'),),
            SizedBox(height:50,),
            Expanded(
              child: FutureBuilder(
                future: loadImages(),
                builder: (contex, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length ?? 0,
                    itemBuilder: (contex, index){
                      final Map image = snapshot.data[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Container(
                                height: 200,
                                child: CachedNetworkImage(
                                  imageUrl: image['url'],
                                  placeholder: (contex,url)=>Image.asset('images/placeholder-image.png'),
                                 errorWidget: (contex,url,error)=>Icon(Icons.error),
                                  ),
                              ),
                            ),
                            ),
                            IconButton(onPressed: ()async{
                              await deleteImage(image['path']);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image deleted successfully'),backgroundColor: Colors.red,));
                            }, icon: Icon(Icons.delete, color: Colors.red,)),
                        ],
                      );
                    }
                    );
                 }
                ),
              ),
          ],
        ),
      ),
    );
  }
}