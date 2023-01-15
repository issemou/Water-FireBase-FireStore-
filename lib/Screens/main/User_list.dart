import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_water/models/userModel.dart';


class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final listuser = <userAppData>[];
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<Iterable<userAppData>>(context);
    var us = users.iterator;
    while(us.moveNext()){
      listuser.add(us.current);
    }
    return ListView.builder(
        itemCount: listuser.length,
        itemBuilder: (context, index){
            return userTile(user:listuser[index]);
        }
    );
  }
}

class userTile extends StatelessWidget {
  const userTile({Key? key, required this.user}) : super(key: key);
  final userAppData user;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
          child:  ListTile(
            title: Text(user.name),
            subtitle: Text('Drink ${user.waterCounter} of glass'),
          ),
        ),
    );
  }
}
