import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_water/Screens/main/home.dart';
import 'package:social_water/Screens/screen_authenticate/authenticate_screen.dart';
import 'package:social_water/models/userModel.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final user = Provider.of<userApp?>(context);
    if (user == null){
      return const AuthenticateScreen();
    }else{
      return  Home();
    }
  }
}