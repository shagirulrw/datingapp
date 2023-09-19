import 'package:datingapp/method/authmethod.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/screens/signin.dart';

import 'package:datingapp/utils.dart';
import 'package:datingapp/widgets/Emailtextfield.dart';
import 'package:datingapp/widgets/backgrounds.dart';
import 'package:datingapp/widgets/keybutton.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: background2(Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      },
                      icon: const Icon(
                        Ionicons.arrow_back_outline,
                        size: 30,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 120.h,
                  ),
                  Center(
                    child: Text(
                      "Forgot Your Password ?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Text(
                    "Email Address",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: Colors.black),
                  ),
                  customtextfield(
                      height: 60.h,
                      width: 323.w,
                      radius: 12,
                      obscure: false,
                      hint: "Enter Your Email Address",
                      controller: emailController),
                  SizedBox(
                    height: 12.h,
                  ),
                  SizedBox(
                    height: height * 0.030,
                  ),
                  InkWell(
                    onTap: () {
                      AuthMethod().forgetPassword(
                          context: context, email: emailController.text);
                      showSnackbar(context, "Link Sent Check Your Email Inbox");
                    },
                    child: keybutton(
                        textsize: 25.sp,
                        kwidth: 328.w,
                        kheight: 66.h,
                        kcolor: primarycolor,
                        ktext: "Send Reset Link"),
                  )
                ],
              ),
            ))),
      ),
    );
  }
}
