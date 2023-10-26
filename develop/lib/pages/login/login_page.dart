import 'dart:convert';

import 'package:develop/Classes/Database/Database/shared_preferences_util.dart';
import '/pages/home.dart';
import '/pages/intro_helper/intro_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/APICalls/endpoints.dart';
import 'package:flutter/material.dart';
import '/widgets/gradientButton/gradient_button.dart';
import '/Classes/dataPoints/loginData.dart';
import '/widgets/lenceFlare/lence_flare.dart';
import '/APICalls/Requests/LocationData.dart';

import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {



  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';
  bool SignUp = true;






  Future<bool> loadFirstTimeLoginFlag() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("FirstTimeLogin") ?? true;
  }

  Future<void> saveFirstTimeLoginFlag(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("FirstTimeLogin", value);
  }


  void login() async {
    String inputUsername = usernameController.text;
    String inputPassword = passwordController.text;

    final url = common_endpoint;
    final route = API_endpoints_MAP["login"];

    final apiUrl = Uri.parse(url + route!); // Update the URL

    final data = {
      'username': inputUsername,
      'password': inputPassword,
    };

    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (responseJson['success'] == true) {
        String user_id = responseJson['user_id'];
        LocationAndUserDataToPassedOBJECT.user_id = user_id;
        LocationAndUserDataToPassedOBJECT.email = emailController.text;
        LocationAndUserDataToPassedOBJECT.name = usernameController.text;
        print("Aurthenticated:");
        {
          await loadFirstTimeLoginFlag()? Navigator.push(context, MaterialPageRoute(builder: (context) => IntroHelper())):
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          saveFirstTimeLoginFlag(false);

        }
      }
      else{
        print("Not Aurthenticated:");

      }
    } else {
      setState(() {
        errorMessage = 'Invalid Username or Password';

      });
    }
  }



  void signUp() async {
    String inputUsername = usernameController.text;
    String inputEmail = emailController.text;
    String inputPassword = passwordController.text;

    final apiUrl = Uri.parse(common_endpoint + API_endpoints_MAP['signup']!); // Update the URL

    final data = {
      'email': inputEmail,
      'password': inputPassword,
      'username': inputUsername,
    };

    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);

      if (responseJson['success'] == true) {
        setState(() {
          errorMessage = ''; // Clear any previous error message
          String user_id = responseJson['user_id'];
          // Update the LocationAndUserDataToPassedOBJECT
          LocationAndUserDataToPassedOBJECT.authenticated = true;
          LocationAndUserDataToPassedOBJECT.user_id = user_id; // Store the user_id
          LocationAndUserDataToPassedOBJECT.email = inputEmail;
          LocationAndUserDataToPassedOBJECT.name = inputUsername;
        });

        // Navigate to the next screen (or perform other actions)
        setState(() {
          SignUp = true;
          usernameController.text = "";
          emailController.text="";
          passwordController.text="";
        });
      }
    } else {
      setState(() {
        errorMessage = 'User registration failed';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return
        //login
        Scaffold(
      backgroundColor: Colors.black,
      body: SignUp
          ? Stack(
              children: [
                LensFlareContainer(
                  diameter: 250.0, // Specify the diameter
                  color: Color(0xFF4D1F3E), // Specify the color
                  x: MediaQuery.of(context).size.width * 3 / 6, // X-coordinate
                  y: MediaQuery.of(context).size.height *
                      25 /
                      100, // Y-coordinate
                  opacity: 1.0,
                ),
                LensFlareContainer(
                  diameter: 120.0, // Specify the diameter
                  color: Color(0xFF08594C), // Specify the color
                  x: MediaQuery.of(context).size.width * 5 / 12, // X-coordinate
                  y: MediaQuery.of(context).size.height *
                      5 /
                      12, // Y-coordinate
                  opacity: 0.9,
                ),
                LensFlareContainer(
                  diameter: 200.0, // Specify the diameter
                  color: Color(0xFF08594C), // Specify the color
                  x: MediaQuery.of(context).size.width * 2 / 12, // X-coordinate
                  y: MediaQuery.of(context).size.height *
                      9 /
                      12, // Y-coordinate
                  opacity: 0.5,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.transparent, // Background color set to black
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * (3 / 5),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/logo-no-background 1.png',
                              width: 210.0,
                              height: 41.79,
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    (1 / 9)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              child: TextField(
                                controller: usernameController,
                                style: TextStyle(
                                    color:
                                        Colors.white), // Text color set to white
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Colors
                                          .white), // Label color set to white
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors
                                          .white), // Icon color set to white
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: TextStyle(
                                    color: Colors
                                        .white), // Text color set to white
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Colors
                                          .white), // Label color set to white
                                  prefixIcon: Icon(Icons.lock,
                                      color: Colors
                                          .white), // Icon color set to white
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {
                                // Implement forgot password logic
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            GradientButton(
                              width: 200,
                              height: 30,
                              onClick: login,
                              buttonText: "Sign In",
                            ),
                            SizedBox(height: 32.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account? ",
                                    style: TextStyle(color: Colors.white)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      errorMessage = '';
                                      SignUp = false;
                                    });
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          :
          //    sign up
          Stack(
              children: [
                LensFlareContainer(
                  diameter: 200.0, // Specify the diameter
                  color: Color(0xFF4D1F3E), // Specify the color
                  x: MediaQuery.of(context).size.width * 1 / 5, // X-coordinate
                  y: MediaQuery.of(context).size.height * 1 / 4, // Y-coordinate
                  opacity: 1.0,
                ),
                LensFlareContainer(
                  diameter: 120.0, // Specify the diameter
                  color: Color(0xFF08594C), // Specify the color
                  x: MediaQuery.of(context).size.width * 7 / 12, // X-coordinate
                  y: MediaQuery.of(context).size.height *
                      5 /
                      12, // Y-coordinate
                  opacity: 0.9,
                ),
                LensFlareContainer(
                  diameter: 200.0, // Specify the diameter
                  color: Color(0xFF08594C), // Specify the color
                  x: MediaQuery.of(context).size.width * 2 / 12, // X-coordinate
                  y: MediaQuery.of(context).size.height *
                      9 /
                      12, // Y-coordinate
                  opacity: 0.5,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.transparent, // Background color set to black
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * (3 / 5),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/logo-no-background 1.png',
                              width: 210.0,
                              height: 41.79,
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    (1 / 9)),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              child: TextField(
                                controller: usernameController,
                                style: TextStyle(
                                    color:
                                        Colors.white), // Text color set to white
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Colors
                                          .white), // Label color set to white
                                  prefixIcon: Icon(Icons.person,
                                      color: Colors
                                          .white), // Icon color set to white
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(
                                    color:
                                        Colors.white), // Text color set to white
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color: Colors
                                          .white), // Label color set to white
                                  prefixIcon: Icon(Icons.email,
                                      color: Colors
                                          .white), // Icon color set to white
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 50,
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                style: TextStyle(
                                    color:
                                        Colors.white), // Text color set to white
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Colors
                                          .white), // Label color set to white
                                  prefixIcon: Icon(Icons.lock,
                                      color: Colors
                                          .white), // Icon color set to white
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .white), // Border color set to white
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 16.0),
                            GradientButton(
                              width: 200,
                              height: 30,
                              onClick: signUp,
                              buttonText: "Sign Up",
                            ),
                            SizedBox(height: 32.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account? ",
                                    style: TextStyle(color: Colors.white)),
                                InkWell(
                                  onTap: () {
                                    setState(() {

                                      errorMessage = '';
                                      SignUp = true;
                                    });
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}












