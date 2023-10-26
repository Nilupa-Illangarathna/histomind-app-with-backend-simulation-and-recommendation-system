import 'package:develop/Classes/dataPoints/location_details.dart';
import 'package:develop/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '/pages/intro_helper/intro_helper.dart';
import '/Classes/Database/Database/shared_preferences_util.dart';
import 'package:provider/provider.dart';
import '/pages/login/login_page.dart';
import '/pages/googleMapLocationFinder/get_nearest_landmark.dart';
import '/APICalls/Requests/LocationData.dart';

void main() async {
  // Initialize SharedPreferences
  WidgetsFlutterBinding
      .ensureInitialized(); // Required to use SharedPreferences in the main function
  final prefs = await SharedPreferences.getInstance();
  SharedPreferencesDatabase.initialize(prefs);
  String firsttime = await SharedPreferencesDatabase.loadVariable("NotInTheFirstTimeLogKey", "NotInTheFirstTimeLog");
  if(firsttime=="NotInTheFirstTimeLog"){
    SharedPreferencesDatabase.saveVariable("NotInTheFirstTimeLogKey",  "true");
  }
  print("Hello World " + firsttime);
  String secondtime = await SharedPreferencesDatabase.loadVariable("NotInTheFirstTimeLogKey", "true");
  print("Hello World " );
  print(secondtime);
  runApp(
    MyApp(),
  );
}

ThemeData myTheme = ThemeData(
  backgroundColor: Colors.black,
  primaryColor: Colors.blue, // Change to your desired primary color
  hintColor: Colors.grey.shade900, // Change to your desired hint color
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPreferencesDatabase.saveVariable("CurrentPathMap",
        [
          Location(id: "0", place: "New York, USA", lat: 40.7128, lon: -74.0060),
          Location(id: "1", place: "Los Angeles, USA", lat: 34.0522, lon: -118.2437),
          Location(id: "2", place: "Chicago, USA", lat: 41.8781, lon: -87.6298),
          Location(id: "3", place: "San Francisco, USA", lat: 37.7749, lon: -122.4194),
          Location(id: "4", place: "Miami, USA", lat: 25.7617, lon: -80.1918),
          Location(id: "5", place: "Las Vegas, USA", lat: 36.1699, lon: -115.1398),

        ] ?? []);
    getLocation();
    return MaterialApp(
      initialRoute:
          LocationAndUserDataToPassedOBJECT.authenticated ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/helper': (context) => const IntroHelper(),
        '/home': (context) => HomePage(),
      },
      theme: myTheme, // Set the defined theme here

      // home: IntroHelper(),
      debugShowCheckedModeBanner: false,
    );
  }
}
