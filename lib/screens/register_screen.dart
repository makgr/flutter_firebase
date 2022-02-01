import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/login_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password Again',
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
                    }else if(passwordController.text != confirmPasswordController.text){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password do not match with confirmpassword'),backgroundColor: Colors.red,));
                    }else{
                     User? result = await authService().register(emailController.text, passwordController.text);
                     if(result != null){
                       print('success');
                       print(result.email);
                     }
                    }
                  },
                  child: Text('Submit'),
                  ),
              ),
              SizedBox(height: 30,),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (contex)=>LoginScreen()));
                },
                 child: Text('Already have an account? Log in'),
                 ),
              
            ],
        ),
      ),
    );
  }
}