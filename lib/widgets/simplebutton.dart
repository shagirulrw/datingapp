import 'package:flutter/material.dart';

Widget simplebutton(
    {required double sheight,
    required double swidth,
    required Color scolor,
    required String text,
    required textsize,
    required bool sborder,
    required double borderradius}) {
  return Container(
    height: sheight,
    width: swidth,
    decoration: BoxDecoration(
      color: scolor,
      borderRadius: BorderRadius.circular(borderradius),
      border:
          Border.all(width: 2, color: sborder ? Colors.black : Colors.white),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(fontSize: textsize, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
