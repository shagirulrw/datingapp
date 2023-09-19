import 'package:datingapp/method/authmethod.dart';
import 'package:datingapp/provider/user_provider.dart';

import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/screens/signin.dart';
import 'package:datingapp/widgets/Emailtextfield.dart';
import 'package:datingapp/widgets/backgrounds.dart';
import 'package:datingapp/widgets/keybutton.dart';
import 'package:datingapp/widgets/simplebutton.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
        child: background1(Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 41.h,
                ),
                Row(
                  children: [
                    simplebutton(
                        sheight: 52.h,
                        swidth: 97.w,
                        // height * 0.060, width * 0.23,
                        scolor: primarycolor,
                        text: "Sign-Up",
                        // 40,
                        textsize: 18.sp,
                        sborder: true,
                        borderradius: 40),
                    SizedBox(width: 15.w),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      },
                      child: simplebutton(
                          sheight: 52.h,
                          swidth: 97.w,
                          scolor: basecolor,
                          text: "Sign-In",
                          borderradius: 40,
                          sborder: true,
                          textsize: 18.sp),
                    ),
                  ],
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 64.sp,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 91.h,
                ),
                Text(
                  "Username",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black),
                ),
                // TextField(
                //   controller: usernameController,
                // ),
                customtextfield(
                  height: 60.h,
                  width: 323.w,
                  radius: 12,
                  obscure: false,
                  controller: usernameController,
                  hint: "Enter Your Username",
                ),
                SizedBox(
                  height: 12.h,
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
                Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black),
                ),
                customtextfield(
                    height: 60.h,
                    width: 323.w,
                    radius: 12,
                    obscure: true,
                    hint: "Enter Your Password",
                    controller: passwordController),
                SizedBox(
                  height: height * 0.030,
                ),
                InkWell(
                  onTap: () {
                    print("signing in....");
                    AuthMethod().signUpWithEmail(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: usernameController.text.trim(),
                        context: context);

                    context.read<UserProvider>().username =
                        usernameController.text;
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const Authwrapper()),
                    // );
                  },
                  child: keybutton(
                      textsize: 25.sp,
                      kwidth: 328.w,
                      kheight: 66.h,
                      kcolor: primarycolor,
                      ktext: "NEXT"),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
