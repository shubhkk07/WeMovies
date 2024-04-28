import 'package:flutter/material.dart';

class CustomDesignBox extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Color.fromARGB(44, 25, 20, 28);
    final Path path1 = Path();

    path1.addRRect(RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(20)));

    final Path path2 = Path();

    path2.moveTo(0, 0);

    path2.lineTo(size.width * 0.5, 0);
    path2.arcToPoint(Offset(size.width * 0.5 - 20, 0 + 20), radius: Radius.circular(20), clockwise: false);
    path2.lineTo(size.width * 0.5 - 20, size.height * 0.1);
    path2.lineTo(0 + 20, size.height * 0.3);
    path2.arcToPoint(Offset(0, size.height * 0.3 + 20), radius: Radius.circular(20), clockwise: false);
    path2.close();

    final Path path3 = Path();
    path3.addRRect(RRect.fromLTRBAndCorners(0, 0, (size.width * 0.5) - 20, size.height * 0.3, bottomRight: Radius.circular(20)));

    final Path path4 = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 0.85 - 20, size.height)
      ..arcToPoint(Offset(size.width * 0.85, size.height - 20), radius: Radius.circular(20), clockwise: false)
      ..lineTo(size.width * 0.85 + 20, size.height * 0.6)
      ..lineTo(size.width - 20, size.height * 0.6)
      ..arcToPoint(Offset(size.width, size.height * 0.6 - 20), radius: Radius.circular(20), clockwise: false)
      ..close();

    final Path path5 = Path();
    path5.addRRect(
        RRect.fromLTRBAndCorners(size.width * 0.85, size.height * 0.6, size.width, size.height, topLeft: Radius.circular(20)));

    Path newPath = Path.combine(PathOperation.difference, path1, path2);

    Path endPath = Path.combine(PathOperation.difference, newPath, path3);

    Path endPath1 = Path.combine(PathOperation.difference, endPath, path4);

    Path endPath2 = Path.combine(PathOperation.difference, endPath1, path5);

    canvas.drawPath(
      endPath2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
