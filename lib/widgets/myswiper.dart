import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cardprovider.dart';

class Tindercard extends StatefulWidget {
  bool isFront;
  Widget child;
  Tindercard({Key? key, required this.isFront, required this.child})
      : super(key: key);

  @override
  State<Tindercard> createState() => _TindercardState();
}

class _TindercardState extends State<Tindercard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isFront ? buildfrontcard() : Buildcard(),
    );
  }

  Widget buildfrontcard() => GestureDetector(onPanStart: ((details) {
        final provider = Provider.of<CardProvider>(context, listen: false)
            .startPosition(details);
      }), onPanEnd: ((details) {
        final provider =
            Provider.of<CardProvider>(context, listen: false).endPosition();
      }), onPanUpdate: ((details) {
        final provider = Provider.of<CardProvider>(context, listen: false)
            .updatePosition(details);
      }), child: LayoutBuilder(
        builder: (context, constraints) {
          final center = constraints.smallest.center(Offset.zero);
          final provider = Provider.of<CardProvider>(context);
          final position = provider.postion;
          // final milliseconds = provider.isDragging ? 0 : 400;
          final milliseconds = provider.speed;
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: Buildcard(),
          );
        },
      )
          //  Buildcard(),
          );
  Widget Buildcard() => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.white,
            child: Center(
              child: widget.child,
            ),
          ),
        ),
      );
}
