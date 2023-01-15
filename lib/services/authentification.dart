
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_water/models/userModel.dart';
import 'package:social_water/services/Databasse.dart';

class AuthentificationService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  userApp ? _userFromFireBase(User? user){
    return user != null ? userApp(uid: user.uid) : null;
  }

  Stream<userApp?> ? get  user{
    return _auth.authStateChanges().map(_userFromFireBase);
  }

  Future singInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User ? user = result.user;
      return _userFromFireBase(user!);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future SignUpWithEmailAndPassword(String name, String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User ? user = result.user;

      //TODO store new User in FireStore(DONE)
      await DatabaseService(user!.uid).saveUser(name, 0);


      return _userFromFireBase(user!);
    } catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future SignOut() async{
    try{
      return await _auth.signOut();
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }
}