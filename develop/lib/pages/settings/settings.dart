import 'package:flutter/material.dart';

import '../../APICalls/Requests/LocationData.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Initialize a variable to store the selected language code.
  String selectedLanguage = 'en'; // Default to English

  // Function to update the selected language.
  void updateLanguage(String? languageCode) {
    if (languageCode != null) {
      setState(() {
        selectedLanguage = languageCode;
        LocationAndUserDataToPassedOBJECT.local=selectedLanguage;
      });
    }
  }

  // Define your function that takes the selected language as a parameter.
  void yourFunction(String languageCode) {
    // Implement your functionality here.
  }

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
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'de', child: Text('German')),
                DropdownMenuItem(value: 'ta', child: Text('Tamil')),
              ],
              onChanged: (String? value) {
                // Update the selected language when the dropdown value changes.
                updateLanguage(value);
              },
            ),
          ),
          ListTile(
            title: Text('Selected Language'),
            subtitle: Text(selectedLanguage),
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



          ElevatedButton(
            onPressed: () {
              // Call your function here with the selected language.
              yourFunction(selectedLanguage);

              // Add code here to save the selected language, e.g., to shared preferences or a global variable.
              // For this example, we'll just print it.
              print('Selected language: $selectedLanguage');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
