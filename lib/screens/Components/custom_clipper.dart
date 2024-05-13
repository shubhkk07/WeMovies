import 'package:flutter/material.dart';

class CustomShapeClipper extends CustomClipper<Path> {
  final double? height;
  final double? width;

  CustomShapeClipper({super.reclip, this.height, this.width});

  @override
  Path getClip(Size size) {
    Path path = Path();

    const radius = Radius.circular(20);

    if (height != null && width != null) {
      final customHeight = size.height * height!;
      final customWidth = size.width * width!;

      path.moveTo(0, customHeight + 20);
      path.arcToPoint(Offset(0 + 20, customHeight), radius: radius);
      path.lineTo(customWidth, customHeight);
      path.arcToPoint(Offset(customWidth + 20, customHeight - 10), radius: radius, clockwise: false);
      path.arcToPoint(Offset(customWidth + 40, 0), radius: radius);
      path.lineTo(size.width, 0);
      path.moveTo(0, customHeight + 20);
    } else {
      path.moveTo(0, size.height * 0.1 + 20);
      path.arcToPoint(Offset(0 + 20, size.height * 0.1), radius: radius);
      path.lineTo(size.width * 0.32, size.height * 0.1);
      path.arcToPoint(Offset(size.width * 0.32 + 20, size.height * 0.1 - 10), radius: radius, clockwise: false);
      path.arcToPoint(Offset(size.width * 0.32 + 20 + 20, 0), radius: radius);
      path.lineTo(size.width, 0);
      path.moveTo(0, size.height * 0.1 + 20);
    }

    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.78 - 20, size.height);
    path.arcToPoint(Offset(size.width * 0.78, size.height - 20), radius: radius, clockwise: false);
    path.arcToPoint(Offset(size.width * 0.78 + 20, size.height - 40), radius: const Radius.circular(20));
    path.arcToPoint(Offset(size.width * 0.78 + 40, size.height - 60), radius: radius, clockwise: false);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
