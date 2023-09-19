import 'package:datingapp/method/authmethod.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/screens/forgotpassword.dart';
import 'package:datingapp/screens/signup.dart';
import 'package:datingapp/widgets/Emailtextfield.dart';
import 'package:datingapp/widgets/backgrounds.dart';
import 'package:datingapp/widgets/keybutton.dart';
import 'package:datingapp/widgets/simplebutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int pressed = 0;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                  SizedBox(
                    height: 41.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          );
                        },
                        child: simplebutton(
                            sheight: 52.h,
                            swidth: 97.w,
                            // height * 0.060, width * 0.23,
                            scolor: basecolor,
                            text: "Sign-Up",
                            // 40,
                            textsize: 18.sp,
                            sborder: true,
                            borderradius: 40),
                      ),
                      SizedBox(width: 15.w),
                      simplebutton(
                          sheight: 52.h,
                          swidth: 97.w,
                          scolor: primarycolor,
                          text: "Sign-In",
                          borderradius: 40,
                          sborder: true,
                          textsize: 18.sp),
                    ],
                  ),
                  SizedBox(
                    height: 120.h,
                  ),
                  Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 64.sp,
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
                  Padding(
                    padding: EdgeInsets.only(right: 15.w, top: 6.h),
                    child: Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()),
                            );
                          },
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                                color: const Color(0xff524A4A)),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.030,
                  ),
                  InkWell(
                    onTap: () {
                      AuthMethod().loginWithEmail(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context);
                    },
                    child: keybutton(
                        textsize: 25.sp,
                        kwidth: 328.w,
                        kheight: 66.h,
                        kcolor: primarycolor,
                        ktext: "Sign In"),
                  )
                ],
              ),
            ))),
      ),
    );
  }
}
