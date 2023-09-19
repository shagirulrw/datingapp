import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage({
    required int index,
    required Uint8List file,
  }) async {
    ////////////////////

    Reference ref = _storage
        .ref()
        .child("photobank")
        .child(_auth.currentUser!.uid)
        .child("$index");
    // UploadTask uploadTask = ref.putData(file);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}
