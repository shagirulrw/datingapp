import 'package:flutter/material.dart';

Widget keybutton(
    {required double kheight,
    required double kwidth,
    required Color kcolor,
    required String ktext,
    required textsize}) {
  return SizedBox(
    height: kheight + 20,
    width: kwidth + 20,
    child: Stack(children: [
      Center(
        child: Container(
          height: kheight,
          width: kwidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: kcolor),
        ),
      ),
      Positioned(
        bottom: 4,
        left: 1.5,
        child: Container(
          height: kheight,
          width: kwidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2, color: Colors.black)),
        ),
      ),
      Center(
        child: Text(
          ktext,
          style: TextStyle(fontSize: textsize, fontWeight: FontWeight.bold),
        ),
      )
    ]),
  );
}
