import 'package:flutter/material.dart';

class MetalEdgesContainer extends StatelessWidget {
  final double width;
  final String imageUrl;
  final double elevation;

  MetalEdgesContainer({
    this.width = 5/7,
    required this.imageUrl,
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * width;

    return Container(
      width: containerSize,
      height: containerSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // Background color of the container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            offset: Offset(0, 0),
            blurRadius: elevation,
            spreadRadius: -elevation / 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover, // Image scaling mode
        ),
      ),
    );
  }
}





// // Calling this
// MetalEdgesContainer(
// imageUrl: imagePath,
// width: MediaQuery.of(context).size.width * (5 / 7),
// elevation: 24,
// ),