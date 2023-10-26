import 'package:flutter/material.dart';

class RadiusSelector extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onSaved; // Add a callback for saving

  RadiusSelector({
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.onSaved, // Initialize the callback
  });

  @override
  _RadiusSelectorState createState() => _RadiusSelectorState();
}

class _RadiusSelectorState extends State<RadiusSelector> {
  double _radius = 0.0;

  @override
  void initState() {
    super.initState();
    _radius = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Radius: ${_radius.toStringAsFixed(2)} miles',
        style: TextStyle(
            color: Colors.white70,
            fontSize: 16
          ),
        ),
        Slider(
          value: _radius,
          min: widget.minValue,
          max: widget.maxValue,
          onChanged: (value) {
            setState(() {
              _radius = value;
            });
            widget.onChanged(value); // Notify the parent widget about the change

            // Automatically save the changed value
            widget.onSaved(value); // Call the save callback
          },
          activeColor: Color(0xFF4D1F3E), // Set the thumb color to red
        ),
      ],
    );
  }
}




// // How to call this
// RadiusSelector(
// initialValue: initialValue,
// minValue: minValue,
// maxValue: maxValue,
// onChanged: (value) {
// // Handle value change if needed
// },
// onSaved: (value) {
// // Save the changed value to a variable or perform other actions
// myVariable = value;
// print('Saved Radius: $value miles');
// },
// )
