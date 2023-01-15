
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userModel.dart';

class DatabaseService{
   String uid;
  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");


  Future<void> saveUser(String name, int waterCounter) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'waterCount': waterCounter
    });
  }

  userAppData _userFromSnapshot(DocumentSnapshot snapshot){
      return userAppData(
          uid: uid,
          name: snapshot.get('name'),
          waterCounter: snapshot.get('waterCount'),
      );
  }


  Stream<userAppData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }


  Iterable<userAppData> _userListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.docs.map( (doc) {
        return _userFromSnapshot(doc);
    });
  }

  Stream<Iterable<userAppData>> get users{
    return userCollection.snapshots().map((_userListFromSnapshot));
  }
}