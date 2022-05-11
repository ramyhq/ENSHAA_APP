
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../data_layer/Cashing_data.dart';
import '../../../data_layer/firestore/firestore_database_services.dart';

class MyUser {
  final String uid;
  final String role ;
  MyUser({this.uid = '',this.role = ''});

}

class AuthBase {
  // create FirebaseAuth and realtime db instance to use it in class
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.ref().child("Users");

  User? ourUser;
  DateTime currentTime = DateTime.now();

  // //create stream of (MyUser status)
  // Stream<MyUser?> get userStatusStream =>
  //     _auth.authStateChanges().map((user) {
  //       var userObject;
  //       if (user != null){
  //         _userFormFirebase(user).then((value) => userObject = value);
  //         return userObject;
  //       } else {
  //         return null;
  //       }
  //     });

  //create stream of (MyUser status)
  Stream<MyUser?> get userStatusStream => _auth.authStateChanges().map((user) {
        return user != null ? MyUser(uid: user.uid) : null;
      });

  Future<MyUser?> _userFormFirebase(user) async {
    var role = '';
    // call users data from realtime db
    await dbRef.child(user!.uid)
        .once()
        .then(( snap) {
      final data = snap.snapshot.value as Map;
      role = data['role'];
      print("#888 the role of user is $role");
    });
    return user != null ? MyUser(uid: user.uid,role: role) : null;
  }


  // register With Email And Password
  Future<MyUser?> registerWithEmailAndPassword(
      String email, String password,String role) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ourUser = authResult.user;
      // this to add to firebase realtime db
      await dbRef.child(ourUser!.uid).set({'email': email, 'role': role});
      // this to add to firebase fireStore db for more features in app later
      await DatabaseServices(uid: ourUser!.uid)
           .updateUserData(email, password, role);
      // this to cash user uid
      await Cashing().setMyData('user_uid', authResult.user!.uid);
      return _userFormFirebase(ourUser);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  // login With Email And Password
  Future<MyUser?> loginWithEmailAndPassword(
      String email, String password) async {
    final authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await Cashing().setMyData('user_email', authResult.user!.email.toString());
    return _userFormFirebase(authResult.user);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }


}
