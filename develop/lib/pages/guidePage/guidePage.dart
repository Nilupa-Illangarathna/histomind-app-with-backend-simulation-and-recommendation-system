import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Guide', style: TextStyle(color: Colors.white70),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Guide Page Content',
          style: TextStyle(fontSize: 24,color: Colors.white70),
        ),
      ),
    );
  }
}