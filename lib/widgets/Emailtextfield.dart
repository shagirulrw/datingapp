import 'package:datingapp/screens/explorepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customtextfield(
    {required double height,
    required double width,
    required double radius,
    required bool obscure,
    required String hint,
    required TextEditingController controller}) {
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      maxLines: 1, keyboardType: TextInputType.text,
      // textAlign: TextAlign.center,
      autocorrect: true,
      enableSuggestions: true,
      obscureText: obscure,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
          filled: true,
          fillColor: secondarycolor, //Color.fromARGB(255, 247, 247, 247),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.black, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: const BorderSide(color: Colors.white, width: 0.5))),
      controller: controller,
    ),
  );
}
