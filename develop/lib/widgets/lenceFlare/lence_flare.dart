import 'package:flutter/material.dart';

class LensFlareContainer extends StatelessWidget {
  final double diameter;
  final Color color;
  final double x;
  final double y;
  final double opacity;

  LensFlareContainer({
    required this.diameter,
    required this.color,
    required this.x,
    required this.y,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x - diameter / 2,
      top: y - diameter / 2,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(opacity),
              spreadRadius: diameter / 14,
              blurRadius: diameter / 1,
            ),
          ],
        ),
      ),
    );
  }
}


// // Calling this
// LensFlareContainer(
// diameter: 200.0, // Specify the diameter
// color: Color(0xFF08594C), // Specify the color
// x: MediaQuery.of(context).size.width * 5 / 6, // X-coordinate
// y: MediaQuery.of(context).size.height * 3 / 12, // Y-coordinate
// opacity: 1.0,
// ),