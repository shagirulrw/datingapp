import 'package:flutter/material.dart';

Widget DrawCircle({required double size, required Color fillColor}) {
  return CustomPaint(
    painter: Drawcircle(csize: size, color: fillColor),
  );
}

class Drawcircle extends CustomPainter {
  final double csize;
  final Color color;
  const Drawcircle({Key? key, required this.csize, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(csize, csize), csize, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
