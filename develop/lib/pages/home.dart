import 'dart:convert';

import '/APICalls/endpoints.dart';
import '/Classes/dataPoints/carousal_data.dart';
import '/widgets/ImageCarousel/customizer_class.dart';

import '/APICalls/Requests/LocationData.dart';
import 'package:flutter/material.dart';
import '/pages/FiltersPage/FilterMenu.dart';
import '/pages/dashboard/dashboard.dart';
import '/pages/chatbot/chat_bot.dart';
import '/pages/google_map/google_map_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  List<Widget> screens = [
    Dashboard(),
    ChatScreen(),
    MapScreen(),
    FiltersMenu(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard(); // Our first view in viewport





  bool isLoading = true;
  List<ImageData> nearbyAttractions = [];
  List<ImageData> recommendedLocations = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    isLoading=true;
  }

  Future<void> fetchData() async {
    final baseUrl = common_endpoint;
    final endpoint = API_endpoints_MAP['recommendation_load']!;


    try {
      final recommendedLocationsResponse = await http.get(Uri.parse('https://histomind-86f011d5789d.herokuapp.com/recommendation-load/652b9e279c8deef2485bf8fb?num_of_rec=5'));
      // final nearbyAttractionsResponse = await http.get(Uri.parse('$baseUrl$endpoint${LocationAndUserDataToPassedOBJECT.user_id}?num_of_rec=10'));


      final String apiUrl = 'https://histomind-86f011d5789d.herokuapp.com/nearest-location?num_of_rec=10&distance=0';

      final Map<String, dynamic> requestData = {
        "latitude": 6.91,
        "longitude": 79.85
      };

      final nearbyAttractionsResponse = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      // if (response.statusCode == 200) {
      //   final data = json.decode(response.body);
      //   print(data);
      //   // You can parse and handle the response data here
      // } else {
      //   throw Exception('Failed to load data');
      // }

      print("DONE");
      print(nearbyAttractionsResponse.statusCode);
      print(recommendedLocationsResponse.statusCode);
      if (nearbyAttractionsResponse.statusCode == 200 && recommendedLocationsResponse.statusCode == 200)  {
        final nearbyAttractionsData = jsonDecode(nearbyAttractionsResponse.body) as List;
        final recommendedLocationsData = jsonDecode(recommendedLocationsResponse.body) as List;


        nearbyAttractions = nearbyAttractionsData
            .map((item) => ImageData.fromJson(item))
            .toList();

        recommendedLocations = recommendedLocationsData
            .map((item) => ImageData.fromJson(item))
            .toList();

        setState(() {
          Nearby_Attractions.setImageDataList(nearbyAttractions);
          Recommendations.setImageDataList(recommendedLocations);
          isLoading = false;
        });
      } else {
        // Handle error cases
      }
    } catch (e) {
      // Handle network and other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationAndUserDataToPassedOBJECT.printProperties();
    return isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      backgroundColor: Colors.black,
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Theme.of(context).hintColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Theme.of(context).hintColor,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Dashboard(); // if user taps on this dashboard tab will be active

                        currentTab = 0;

                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Color(0xFF4D1F3E) : Colors.grey,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            color: currentTab == 0 ? Color(0xFF08594C) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            ChatScreen(); // if user taps on this dashboard tab will be active
                        currentTab = 1;

                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 1 ? Color(0xFF4D1F3E) : Colors.grey,
                        ),
                        Text(
                          'Chats',
                          style: TextStyle(
                            color: currentTab == 1 ? Color(0xFF08594C) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            MapScreen(); // if user taps on this dashboard tab will be active
                        currentTab = 2;

                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? Color(0xFF4D1F3E) : Colors.grey,
                        ),
                        Text(
                          'Map',
                          style: TextStyle(
                            color: currentTab == 2 ? Color(0xFF08594C) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            FiltersMenu(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(builder: (_) => FiltersMenu()),
                        // );
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 3 ? Color(0xFF4D1F3E) : Colors.grey,
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: currentTab == 3 ? Color(0xFF08594C) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}









