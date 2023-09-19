import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final int age;
  final bool gender;
  final bool newmess;
  final String username;
  final String bio;
  final String uid;
  final List<dynamic> photoURLs;
  final List<dynamic> liked;
  final List<dynamic> likedyou;
  final List<dynamic> disliked;
  final List<dynamic> matched;
  final List<dynamic>? details;

  const Users(
      {required this.username,
      required this.uid,
      required this.age,
      required this.gender,
      required this.newmess,
      required this.photoURLs,
      required this.bio,
      required this.liked,
      required this.likedyou,
      required this.disliked,
      required this.matched,
      this.details});
  Map<String, dynamic> toJson() => {
        "age": age,
        "female": gender,
        "username": username,
        "newmess": newmess,
        "bio": bio,
        "uid": uid,
        "photoURLs": photoURLs,
        "liked": liked,
        "likedyou": likedyou,
        "disliked": disliked,
        "matched": matched,
        "details": details
      };
  static Users fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Users(
        age: snapshot["age"],
        gender: snapshot["female"],
        newmess: snapshot["newmess"],
        username: snapshot["username"],
        bio: snapshot["bio"],
        uid: snapshot["uid"],
        photoURLs: snapshot["photoURLs"],
        // email: snapshot["email"],
        liked: snapshot["liked"],
        likedyou: snapshot["likedyou"],
        disliked: snapshot["disliked"],
        matched: snapshot["matched"],
        details: snapshot["details"]);
  }
}
