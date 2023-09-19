import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/main.dart';
import 'package:datingapp/model/usermodel.dart' as model;
import 'package:datingapp/provider/user_provider.dart';
import 'package:datingapp/screens/adddetails.dart';
import 'package:datingapp/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthMethod {
  final FirebaseFirestore _firetore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authstate => FirebaseAuth.instance.authStateChanges();

  Future<model.Users> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firetore.collection("users").doc(currentUser.uid).get();
    print("getuserfunction\n\n\n\n\n\n");
    return model.Users.fromsnap(snap);
  }

  ///////////////////////
  Future<void> signUpWithEmail(
      {required String email,
      required String name,
      required String password,
      required BuildContext context}) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential _cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        context.read<UserProvider>().cred = _cred;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddDetails(
                    cred: _cred,
                  )),
        );
        ////////////////////////////
        _firetore.collection("users").doc(_cred.user!.uid).set({
          "username": name,
          "age": 0,
          "bio": "Add Bio",
          "details": [],
          "liked": [],
          "disliked": [],
          "likedyou": [],
          "matched": [],
          "photoURLs": [],
          "female": false,
          "newmess": false
        });
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

////////////////////////////////////////////////tobeedit
  Future<void> adddetailstocurrentuser(
      {required int age,
      required bool gender,
      String? bio,
      // required String uid,
      required UserCredential credential,
      required List<dynamic> photoURLs,
      required BuildContext context}) async {
    try {
      model.Users users = model.Users(
          gender: gender,
          username: context.read<UserProvider>().username,
          uid: credential.user!.uid,
          newmess: false,
          // uid: uid,
          age: age,
          liked: [],
          likedyou: [],
          disliked: [],
          matched: [],
          bio: bio ?? "",
          details: ["", "", "", "", "", "", "", ""],
          photoURLs: photoURLs);
      try {
        _firetore
            .collection("users")
            .doc(credential.user!.uid)
            // .doc(uid)
            .set(users.toJson());
      } on FirebaseException catch (e) {
        showSnackbar(context, e.message.toString());
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

  Future<void> updatebasicdetails(
      {required int age,
      required String bio,
      required String name,
      required BuildContext context}) async {
    try {
      if (bio.isNotEmpty && name.isNotEmpty) {
        try {
          _firetore
              .collection("users")
              .doc(context.read<UserProvider>().getuser.uid)
              .update({"username": name, "age": age, "bio": bio});
        } on FirebaseException catch (e) {
          showSnackbar(context, e.message.toString());
        }
      } else {
        showSnackbar(context, "Fields can't be empty");
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

////////////////////////////////
  loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // print(_auth.currentUser!.uid);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Authwrapper(),
          ));
      if (!_auth.currentUser!.emailVerified) {}
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

  /////////////////////////////////////////////////////////////////
  Future<void> logOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Authwrapper()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

  ///////////////////////////////////////////
  Future<void> forgetPassword(
      {required BuildContext context, required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
    }
  }

  // Future<String> getUsernmeusingUID({required uid}) {}
  /////////////////////////////////////////////////
}
