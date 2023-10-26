import '/APICalls/Requests/LocationData.dart';
import 'package:flutter/material.dart';
import '/pages/settings/settings.dart';
import '/pages/guidePage/guidePage.dart';
import '/pages/termsPage/termsPage.dart';
import '/pages/profilePage/profilePage.dart';

class CustomAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF4D1F3E),
                Colors.black
              ],
              stops: [0.5,1]
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  SizedBox(height: 32),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    // Replace with your profile picture image
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    LocationAndUserDataToPassedOBJECT.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    LocationAndUserDataToPassedOBJECT.email,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white),
                  title: Text('Home', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text('Profile', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help, color: Colors.white),
                  title: Text('Guide', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GuidePage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.policy, color: Colors.white),
                  title: Text('Terms', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermsPage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.white),
                  title: Text('Settings', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                ),
              ],
            ),
            Expanded(
              child: SizedBox(),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.white),
              title: Text('Sign off', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Perform sign-off action here
              },
            ),
          ],
        ),
      ),
    );
  }
}







