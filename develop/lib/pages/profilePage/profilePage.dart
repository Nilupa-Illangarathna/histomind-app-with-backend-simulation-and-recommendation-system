import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white30),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Profile Page Content',
          style: TextStyle(fontSize: 24,color: Colors.white70),
        ),
      ),
    );
  }
}