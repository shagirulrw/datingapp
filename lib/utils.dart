import 'package:datingapp/screens/chatscreen.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color _basecolor = const Color(0xff1C1D21);
Color _primarycolor = const Color(0xff19BE8E);
Color _keycolor = const Color(0xffEDF583);

final messengerKey = GlobalKey<ScaffoldMessengerState>();
pickImage(ImageSource source, BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  } else {
    showSnackbar(context, "Please Select An Image !!");
  }
}

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: primarycolor,
  ));
}

void showMatchSnackbar(
    BuildContext context, String doc, String name, String photo) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      "It's a match",
      style: TextStyle(fontSize: 20.sp, color: Colors.white),
    ),
    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
    margin: EdgeInsets.only(bottom: 80.h, left: 10.w, right: 10.w),
    backgroundColor: primarycolor,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Chat Now',
      disabledTextColor: primarycolor,
      textColor: Colors.black,
      onPressed: () {
        // Do whatever you want
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(doc: doc, name: name, photo: photo)),
        );
      },
    ),
  ));
}
