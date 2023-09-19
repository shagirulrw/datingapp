// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/method/authmethod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/usermodel.dart';

class UserProvider with ChangeNotifier {
  //////////////////////////////////////
  // int index = 0;

  // //////////////////////////////////
  // void incrementindex() {
  //   // index++;
  //   if (index >= 5) {
  //     index = 0;
  //   } else {
  //     ++index;
  //   }
  //   notifyListeners();
  // }

  // void indexreset() {
  //   index = 0;
  //   notifyListeners();
  // }

  // void decrementindex() {
  //   // index--;
  //   if (index <= 0) {
  //     index = 5;
  //   } else {
  //     --index;
  //   }
  //   notifyListeners();
  // }

  ///////////////////////////////
  // Stream documentStream =
  //     FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();
  // List<dynamic> result = [];
  late UserCredential cred;
  String username = "no name";
  String get getusername => username;
  bool userGender = false;
  bool get getgender => userGender;
  Users _user = const Users(
      username: "No Name",
      uid: "xyz",
      age: 00,
      gender: false,
      newmess: false,
      photoURLs: [""],
      bio: "",
      liked: [""],
      likedyou: [""],
      matched: [""],
      disliked: [""],
      details: []);
  Users get getuser => _user;

  final AuthMethod _authMethod = AuthMethod();

  Future<void> refrehUser() async {
    Users users = await _authMethod.getUserDetails();
    _user = users;

    notifyListeners();
    // print("updated");
    // print(getuser.uid);
  }
}
