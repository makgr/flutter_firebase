import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email',
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password',
                ),
              ),
              
              SizedBox(height: 30,),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: ()async{
                     if(emailController.text == "" || passwordController.text == ""){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required'),backgroundColor: Colors.red,));
                    }else{
                     User? result = await authService().login(emailController.text, passwordController.text);
                     if(result != null){
                       print('success');
                       print(result.email);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (contex)=>Homescreen(result)), (route) => false);
                     }
                    }
                  },
                  child: Text('Login'),
                  ),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: (){

                },
                 child: Text('Register'),
                 ),
              
            ],
        ),
      ),
    );
  }
}