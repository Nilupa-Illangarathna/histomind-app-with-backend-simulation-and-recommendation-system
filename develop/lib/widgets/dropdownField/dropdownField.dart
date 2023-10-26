import 'package:flutter/material.dart';



class MyDropdownMenu extends StatefulWidget {
  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(20), // Rounded left corner
          right: Radius.circular(20), // Rounded right corner
        ),
        gradient: LinearGradient(
          colors: [Color(0xFF4D1F3E), Color(0xFF08594C)], // Gradient colors (left-to-right)
        ),
      ),
      child: DropdownButtonFormField<String>(

        onChanged: (newValue) {
          setState(() {

          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          hintText: 'Choose an option',
          hintStyle: TextStyle(color: Colors.white70),
          prefixIcon: Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20), // Rounded left corner
              right: Radius.circular(20), // Rounded right corner
            ),
            borderSide: BorderSide.none,
          ),
          labelText: 'Select an option', // Use the label text here
          labelStyle: TextStyle(color: Colors.white), // Label text style
        ),
        items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
      ),
    );
  }
}
