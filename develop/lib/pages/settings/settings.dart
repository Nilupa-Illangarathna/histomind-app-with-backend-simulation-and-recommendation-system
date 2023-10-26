import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: Text('Language Selection'),
            subtitle: Text('Choose your preferred language'),
            leading: Icon(Icons.language),
            onTap: () {
              // Implement language selection functionality
            },
          ),
          ListTile(
            title: Text('User Profile and Settings'),
            subtitle: Text('Customize language, notifications, theme, and preferences'),
            leading: Icon(Icons.person),
            onTap: () {
              // Navigate to user profile and settings screen
              Navigator.pushNamed(context, '/user_profile_settings');
            },
          ),
          ListTile(
            title: Text('Feedback and Support'),
            subtitle: Text('Provide feedback and access support'),
            leading: Icon(Icons.feedback),
            onTap: () {
              // Navigate to feedback and support screen
              Navigator.pushNamed(context, '/feedback_support');
            },
          ),
          ListTile(
            title: Text('Language Switcher'),
            subtitle: Text('Change the preferred language'),
            leading: Icon(Icons.settings),
            onTap: () {
              // Implement language switcher functionality
            },
          ),
        ],
      ),
    );
  }
}
