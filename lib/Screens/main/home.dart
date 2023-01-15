import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_water/common/loading.dart';
import 'package:social_water/models/userModel.dart';
import 'package:social_water/services/Databasse.dart';
import 'package:social_water/services/authentification.dart';

import 'User_list.dart';

class Home extends StatelessWidget {
  final AuthentificationService _auth = AuthentificationService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userApp>(context);
    return StreamProvider<Iterable<userAppData>>.value(
      initialData: [],
      value: DatabaseService('').users,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            elevation: 8.8,
            title: Text("Social Water"),
            actions: [
              StreamBuilder<userAppData>(
                stream: DatabaseService(user.uid).user,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    userAppData? userData = snapshot.data;
                    return TextButton.icon(
                      onPressed: () async {
                        await DatabaseService(user.uid).saveUser(userData!.name, userData!.waterCounter + 1);
                      },
                      icon: Icon(Icons.wine_bar, color: Colors.white,),
                      label: Text("Drink", style: TextStyle(color: Colors.white),)
                  );
                  }else{
                    return Loading();
                  }
                },
              ),
              TextButton.icon(
                  onPressed: () async { await _auth.SignOut(); },
                  icon: Icon(Icons.logout, color: Colors.white,),
                  label: Text("LogOut", style: TextStyle(color: Colors.white),)
              ),
            ],
          ),
          body: const UserList(),
        );
      }
    );
  }

  toggleDrink() {}
}
