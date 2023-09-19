import 'package:datingapp/screens/explorepage.dart';
import 'package:flutter/material.dart';
import 'circlewidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget background2(Widget? bwidget) {
  return Container(
      height: double.infinity,
      color: basecolor,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            right: 100,
            child: Container(
                child: DrawCircle(size: 120, fillColor: primarycolor)),
          ),
          Positioned(
            top: 140,
            left: -60,
            child:
                Container(child: DrawCircle(size: 60, fillColor: primarycolor)),
          ),
          Positioned(
            bottom: 90,
            left: -60,
            child: Container(
                child: DrawCircle(size: 120, fillColor: primarycolor)),
          ),
          Container(
            child: bwidget,
          ),
        ],
      ));
}

Widget background1(Widget? bwidget) {
  return Container(
      height: double.infinity,
      color: basecolor,
      child: Stack(
        children: [
          Positioned(
            top: -70,
            right: 110,
            child: Container(
                child: DrawCircle(size: 120, fillColor: primarycolor)),
          ),
          Positioned(
            top: 200,
            left: -90,
            child:
                Container(child: DrawCircle(size: 80, fillColor: primarycolor)),
          ),
          Positioned(
            bottom: 60,
            right: 70,
            child:
                Container(child: DrawCircle(size: 60, fillColor: primarycolor)),
          ),
          Container(
            child: bwidget,
          ),
        ],
      ));
}

Widget matchbackground(Widget? bwidget) {
  return Container(
      height: double.infinity,
      color: basecolor,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // Positioned(
          //   top: -70,
          //   child: Container(
          //       child: DrawCircle(size: 200, fillColor: primarycolor)),
          // ),
          Positioned(
            top: -680.h,
            left: -190.w,
            child: Container(
                child: DrawCircle(size: 350, fillColor: primarycolor)),
          ),
          Positioned(
            top: 490.h,
            left: -400.w,
            child: Container(
                child: DrawCircle(size: 550, fillColor: primarycolor)),
          ),
          Container(
            child: bwidget,
          ),
        ],
      ));
}
