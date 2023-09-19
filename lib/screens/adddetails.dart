// import 'dart:html';

import 'dart:typed_data';
import 'package:datingapp/main.dart';
import 'package:datingapp/method/authmethod.dart';
import 'package:datingapp/provider/user_provider.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/utils.dart';
import 'package:datingapp/widgets/backgrounds.dart';
import 'package:datingapp/widgets/keybutton.dart';
import 'package:datingapp/widgets/simplebutton.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../method/storage_method.dart';
// import '../utils.dart';
import '../widgets/Emailtextfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDetails extends StatefulWidget {
  UserCredential? cred;

  AddDetails({Key? key, this.cred}) : super(key: key);

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

double ageSlider = 36;
bool female = false;
bool button = false;
List<Uint8List?> imagelist = [];
///////////////////////////////////////
//////////////////////////////////////
int imgbucketL = imagelist.length;
List<dynamic> photoURLs = [];

class _AddDetailsState extends State<AddDetails> {
  final bioController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void selectImage(int index) async {
      final img = await pickImage(ImageSource.gallery, context);

      setState(() {
        if (imagelist.length < 6) {
          imagelist.add(img);
        }
      });
    }
    //////////////////////////////

    Future<List<dynamic>> uploadToStorage() async {
      List<dynamic> bucket = [];
      for (int i = 0; i < 6; i++) {
        String photourl = await StorageMethod()
            .uploadImageToStorage(file: imagelist[i]!, index: i);
        bucket.add(photourl);
      }

      return bucket;
    }

    ////////////////////////////////////////////////image title widget
    Widget gettile(int i) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 7.h),
        child: Stack(children: [
          imagelist.length > i
              ? Stack(children: [
                  Container(
                    height: 100.h,
                    width: 97.w,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 247, 247, 247),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: MemoryImage(
                              imagelist.elementAt(i)!,
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      right: 1.w,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            imagelist.removeAt(i);
                          });
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.black,
                        ),
                      ))
                ])
              : InkWell(
                  onTap: () {
                    selectImage(i);
                  },
                  child: Container(
                    height: 100.h,
                    width: 97.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 247, 247),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: Colors.black26,
                    ),
                  ),
                ),
        ]),
      );
    }

///////////////////////////////////////////////////////////////
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: background1(Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Text(
                  context.read<UserProvider>().getusername,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 64.sp,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 42.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        female = false;
                      });
                      context.read<UserProvider>().userGender = false;
                    },
                    child: simplebutton(
                        sheight: 53.h,
                        swidth: 119.w,
                        scolor: (female) ? secondarycolor : primarycolor,
                        text: "MALE",
                        borderradius: 12,
                        sborder: false,
                        textsize: 20.sp),
                  ),
                  SizedBox(width: 7.w),
                  InkWell(
                    onTap: () {
                      setState(() {
                        female = true;
                      });
                      context.read<UserProvider>().userGender = true;
                    },
                    child: simplebutton(
                        sheight: 53.h,
                        swidth: 119.w,
                        scolor: (!female) ? secondarycolor : primarycolor,
                        text: "FEMALE",
                        borderradius: 12,
                        sborder: false,
                        textsize: 20.sp),
                  ),
                ],
              ),
              Center(
                child: Text(
                  ageSlider.round().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 64.sp,
                      color: Colors.black),
                ),
              ),
              Slider(
                activeColor: primarycolor,
                inactiveColor: const Color.fromARGB(255, 247, 247, 247),
                value: ageSlider,
                min: 18,
                max: 82,
                divisions: 100,
                label: ageSlider.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    ageSlider = value;
                  });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Bio",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              customtextfield(
                  height: 57.h,
                  width: 339.w,
                  radius: 12,
                  obscure: false,
                  hint: "Enter Your Short Bio",
                  controller: bioController),
              SizedBox(height: 20.h),
              Column(
                children: [
                  Row(children: [
                    gettile(0),
                    gettile(1),
                    gettile(2),
                  ]),
                  Row(
                    children: [
                      gettile(3),
                      gettile(4),
                      gettile(5),
                    ],
                  )
                ],
              ),
              InkWell(
                onTap: () async {
                  if (imagelist.length == 6 &&
                      button == false &&
                      bioController.text.isNotEmpty) {
                    print("adding data");

                    setState(() {
                      button = true;
                    });
                    photoURLs = await uploadToStorage();
                    // print("photos uploaded");

                    await AuthMethod().adddetailstocurrentuser(
                        age: ageSlider.round(),
                        gender: female,
                        bio: bioController.text.trim(),
                        credential: widget.cred!,
                        photoURLs: photoURLs,
                        context: context);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Authwrapper()),
                    );
                  } else {
                    showSnackbar(
                        context,
                        bioController.text.isEmpty
                            ? "Please Add your short bio"
                            : "You Have To Select Six photos");
                  }
                },
                child: keybutton(
                    textsize: 25.sp,
                    kwidth: 328.w,
                    kheight: 66.h,
                    kcolor: button ? secondarycolor : primarycolor,
                    ktext: "Sign-Up"),
              )
            ],
          ),
        ),
      )),
    ));
  }
}
