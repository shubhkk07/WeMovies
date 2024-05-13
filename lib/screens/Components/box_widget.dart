import 'package:flutter/material.dart';

class BoxClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final customHeight = size.height * 0.25;
    final customWidth = size.width * 0.4;
    const radius = Radius.circular(20);

    path.moveTo(0, customHeight + 20);
    path.arcToPoint(Offset(0 + 20, customHeight), radius: radius);
    path.lineTo(customWidth, customHeight);
    path.arcToPoint(Offset(customWidth + 15, customHeight - 15), radius: radius, clockwise: false);
    path.arcToPoint(Offset(customWidth + 30, 0), radius: radius);
    path.lineTo(size.width, 0);
    path.moveTo(0, customHeight + 20);

    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.85 - 20, size.height);
    path.arcToPoint(Offset(size.width * 0.85, size.height - 20), radius: radius, clockwise: false);
    path.arcToPoint(Offset(size.width * 0.85 + 30, size.height - 40), radius: const Radius.circular(20));
    path.arcToPoint(Offset(size.width, size.height - 60), radius: Radius.circular(20), clockwise: false);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
