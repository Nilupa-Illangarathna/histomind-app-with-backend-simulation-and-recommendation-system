import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double width;
  final double height;
  final Function() onClick;
  final String buttonText;

  GradientButton({
    required this.width,
    required this.height,
    required this.onClick,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4D1F3E),
              Color(0xFF08594C),
            ],
          ),
          borderRadius: BorderRadius.circular(height / 2), // Make it circular
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold, // Bold text
              fontSize: 16.0, // Adjust the font size as needed
            ),
          ),
        ),
      ),
    );
  }
}




// // Calling this
// GradientButton(
// width: 100,
// height: 50,
// onClick: nextSlide,
// buttonText: "Next",
// ),
//
//
// // Function / nvgation
// void nextSlide() {
//   controller.animateToPage(slideIndex + 1,
//       duration: Duration(milliseconds: 500), curve: Curves.linear);
// }