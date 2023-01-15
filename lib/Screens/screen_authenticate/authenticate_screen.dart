import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:social_water/common/constant.dart';
import 'package:social_water/services/authentification.dart';

import '../../common/loading.dart';
class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {

  final AuthentificationService _auth = AuthentificationService();

  final _formKey = GlobalKey<FormState>();
  String error = "";
  bool loading =  false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void toggleView(){
    setState(() {
      _formKey.currentState!.reset();
      error = '';
      emailController.text = '';
      passwordController.text = '';
      nameController.text = '';
      showSignIn = !showSignIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 8.8,
        title: Text(showSignIn ? 'Sign In to Water Social' : 'Sign Up to Water Social'),
        actions: [
          TextButton.icon(
              onPressed: () => toggleView(),
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text(showSignIn ? 'Sign Up' : 'Sign In', style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              !showSignIn ? TextFormField(
                controller: nameController,
                decoration: textInputDecoration.copyWith(hintText: "Enter name"),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ) : SizedBox(),

              !showSignIn ? SizedBox(height: 10.0,) : Container(),
              TextFormField(
                controller: emailController,
                decoration: textInputDecoration.copyWith(hintText: "Enter an Email"),
                validator: (value) => value!.isEmpty ? "Enter an Email" : null,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: passwordController,
                decoration: textInputDecoration.copyWith(hintText: "Enter Password"),
                obscureText: true,
                validator: (value) =>
                value!.length < 6 ? "Enter valid Password at leat 6 charactere" : null ,
              ),
              SizedBox(height: 10.0,),
              ElevatedButton(
                style:  ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blueGrey)
                ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      var email = emailController.value.text;
                      var password = passwordController.value.text;
                      var name =  nameController.value.text;

                      //TODO CALL fireBase Auth(DONE)
                      dynamic result = showSignIn ?
                      await _auth.singInWithEmailAndPassword(email, password) :
                      await _auth.SignUpWithEmailAndPassword(name, email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          error = "Please Supply a valid email";
                        });
                      }
                    }
                  },
                  child: Text(
                    showSignIn ? "Sign In ": "Sign Up",
                    style: TextStyle(color: Colors.white),
                  )
              ),
              SizedBox(
                height: 10.0,
                child: Text(
                  error,
                  style: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
