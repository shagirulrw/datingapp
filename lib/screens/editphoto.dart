import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/method/storage_method.dart';

import 'package:datingapp/screens/explorepage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datingapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../model/usermodel.dart';
import '../provider/user_provider.dart';

class EditPhotoPage extends StatefulWidget {
  EditPhotoPage({Key? key}) : super(key: key);

  @override
  State<EditPhotoPage> createState() => _EditPhotoPageState();
}

// List<Uint8List?> imagelist = [];
///////////////////////////////////////
//////////////////////////////////////
// int imgbucketL = imagelist.length;
// List<dynamic> photoURLs = [];

class _EditPhotoPageState extends State<EditPhotoPage> {
  @override
  Widget build(BuildContext context) {
    Users currentuser =
        Provider.of<UserProvider>(context, listen: false).getuser;

    Future<void> uploadToStorage(Uint8List f, int i) async {
      List<dynamic> newurllist = currentuser.photoURLs;

      String photourl =
          await StorageMethod().uploadImageToStorage(file: f, index: i);

      newurllist[i] = photourl;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentuser.uid)
          .update({"photoURLs": newurllist});

      context.read<UserProvider>().refrehUser();
    }

    void selectImage(int index) async {
      // if (imgbucketL <= 5) {

      final img = await pickImage(ImageSource.gallery, context);
      uploadToStorage(img, index);
      context.read<UserProvider>().refrehUser();
    }

    Widget gettile(
        {required int i, required int h, required int w, required String url}) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
        child: Stack(children: [
          InkWell(
              onTap: () {
                print("tile idex: $i");
                // if (imgbucketL == i) {
                // selectImage(i);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 500.h,
                          width: 500.w,
                          child: Image.network(url, fit: BoxFit.cover),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        IconButton(
                            onPressed: () {
                              selectImage(i);
                              Navigator.pop(context);
                            },
                            icon: const Center(
                              child: Icon(
                                Ionicons.create_outline,
                                size: 30,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                color: secondarycolor,
                height: h.h,
                width: w.w,
                child: Image.network(url, fit: BoxFit.cover),
              )),
        ]),
      );
    }

    return SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("uid", isEqualTo: currentuser.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  switch (snapshot.connectionState) {
                    //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox(
                        child: Text(""),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Ionicons.arrow_back_outline,
                                    size: 30,
                                    color: Colors.black,
                                  )),
                              Center(
                                child: Text(
                                  "Photos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40.sp,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 42.h,
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  gettile(
                                      i: 0,
                                      h: 270,
                                      w: 215,
                                      url: snapshot
                                          .data!.docs.first["photoURLs"][0]),
                                  Row(
                                    children: [
                                      gettile(
                                          i: 3,
                                          h: 130,
                                          w: 100,
                                          url: snapshot.data!.docs
                                              .first["photoURLs"][3]),
                                      gettile(
                                          i: 4,
                                          h: 130,
                                          w: 100,
                                          url: snapshot.data!.docs
                                              .first["photoURLs"][4]),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  gettile(
                                      i: 1,
                                      h: 130,
                                      w: 100,
                                      url: snapshot
                                          .data!.docs.first["photoURLs"][1]),
                                  gettile(
                                      i: 2,
                                      h: 130,
                                      w: 100,
                                      url: snapshot
                                          .data!.docs.first["photoURLs"][2]),
                                  gettile(
                                      i: 5,
                                      h: 130,
                                      w: 100,
                                      url: snapshot
                                          .data!.docs.first["photoURLs"][5]),
                                ],
                              )
                            ],
                          )
                        ],
                      );
                  }
                })));
  }
}
