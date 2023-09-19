import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:datingapp/model/messagemodel.dart';
import 'package:datingapp/model/usermodel.dart' as model;

import 'package:datingapp/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMethod {
  final FirebaseFirestore _firetore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authstate => FirebaseAuth.instance.authStateChanges();
  // void matchscreen(
  //     {required BuildContext context, required String cx, required String tx}) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: MatchScreen(phototx: cx, photorx: tx),
  //     // backgroundColor: ,
  //   ));
  // }
  Future<void> removeLike(
      {required String currentuid,
      // final snap,
      required String targetuid,
      // required String cx,
      // required String tx,
      required BuildContext context}) async {
    _firetore.collection('users').doc(currentuid).update({
      "liked": FieldValue.arrayRemove([targetuid])
    });
  }

  Future<void> firebasedisLike(
      {required String currentuid,
      // final snap,
      required String targetuid,
      // required String cx,
      // required String tx,
      required BuildContext context}) async {
    _firetore.collection('users').doc(currentuid).update({
      "disliked": FieldValue.arrayUnion([targetuid])
    });
  }

////////////////////////////////////////////////tobeedit
  Future<void> firebaseLike(
      {required String currentuid,
      required String targetuid,
      required BuildContext context}) async {
    List<dynamic> likedlist = [];

    DocumentSnapshot snap =
        await _firetore.collection("users").doc(targetuid).get();
    model.Users user1 = model.Users.fromsnap(snap);
    likedlist = user1.liked;

    if (likedlist.contains(currentuid)) {
      //////////////nope
      // matchscreen(cx: cx, tx: tx, context: context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => MatchScreen(
      //             photorx: cx,
      //             phototx: tx,
      //           )),
      // );
      // /////////////////////////exp

      // _firetore.collection('users').doc(currentuid).update({
      //   "liked": FieldValue.arrayUnion([targetuid])
      // });
      ///////////////////////////////////////////match/////////////////////
      String roomid = await roomcodeencode(rxuid: currentuid, txuid: targetuid);

      Message mess = Message(
          message: "hii",
          tx: targetuid,
          rx: currentuid,
          time: Timestamp.now(),
          read: "");
      _firetore
          .collection("chats")
          .doc(roomid)
          .collection("message")
          .doc()
          .set(mess.toJson());
      _firetore.collection('users').doc(currentuid).update({
        "matched": FieldValue.arrayUnion([roomid])
      });
      ///////////////////////
      _firetore.collection('users').doc(targetuid).update({
        "matched": FieldValue.arrayUnion([roomid])
      });

      ////////////////////////////////match////////////////////////////////////////
      _firetore.collection('users').doc(targetuid).update({
        "liked": FieldValue.arrayRemove([currentuid])
      });
      _firetore.collection('users').doc(currentuid).update({
        "likedyou": FieldValue.arrayRemove([targetuid])
      });

      ////////exp above////////////////////////////////remove like on our profile from the opposite account
      showMatchSnackbar(context, roomid, user1.username, user1.photoURLs[0]);
      //////////////////////////////////
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentuid)
          .update({"newmess": true});
    } else {
      // print("else");
      _firetore.collection('users').doc(currentuid).update({
        "liked": FieldValue.arrayUnion([targetuid])
      });
      _firetore.collection('users').doc(targetuid).update({
        "likedyou": FieldValue.arrayUnion([currentuid])
      });
      // _firetore.collection('users').doc(targetuid).update({
      //   "liked": FieldValue.arrayUnion([currentuid])
      // });
      /////////////////////////////////////
    }
  }

//////////////////////////////////////////////////////////////
  Future<void> sendmessage({
    required String currentuid,
    required String message,
    required String targetuid,
    required BuildContext context,
    required String roomid,
  }) async {
    Message mess = Message(
        message: message,
        tx: currentuid,
        rx: targetuid,
        time: Timestamp.now(),
        read: "");
    _firetore
        .collection("chats")
        .doc(roomid)
        .collection("message")
        .doc()
        .set(mess.toJson());

    FirebaseFirestore.instance
        .collection("users")
        .doc(targetuid)
        .update({"newmess": true});
  }

  ///////////////////////////////////////////////////
  ///
  Future<void> updateDetails(
      String uid,
      String? city,
      String? height,
      String? education,
      String? hobbie,
      String? religion,
      String? exercise,
      String? drink,
      String? smoke) async {
    List<String> arr = [
      "$city",
      "$height",
      "$education",
      "$hobbie",
      "$religion",
      "$exercise",
      "$drink",
      "$smoke"
    ];
    print(uid);
    print(arr);

    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({"details": arr});
  }
/////////////////////////////////////////////////////////////

  Future<String> roomcodeencode(
      {required String txuid, required String rxuid}) async {
    String filler = "-";
    String id = txuid + filler + rxuid;
    return id;
  }

  roomcodedecode({required String code, required String currentuserid}) {
    int divpos = code.indexOf("-");
    String a = code.substring(0, divpos);
    String b = code.substring(
      (divpos + 1),
    );
    // print(a);
    // print(b);
    if (a == currentuserid) {
      return b;
    } else {
      return a;
    }
    // return;
  }
}

////////////////////////////////
 