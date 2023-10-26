import 'dart:convert';

import '/APICalls/Requests/LocationData.dart';
import '/APICalls/endpoints.dart';
import '/Classes/dataPoints/carousal_data.dart';
import '/Classes/dataPoints/location_details.dart';
import '/pages/google_map/google_map_screen.dart';
import '/widgets/gradientButton/gradient_button.dart';
import 'package:flutter/material.dart';
import 'customizer_class.dart';
import 'package:http/http.dart' as http;

class ImageCarousel extends StatefulWidget {
  final ImageCarouselSettings settings;

  ImageCarousel({required this.settings});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  ThemeData get theme => Theme.of(context);
  late Color containerColor;
  bool isDarkTheme = false;
  String errorMessage = '';

  late ScrollController _scrollController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: widget.settings.initialPosition,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToNewPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MapScreen(),
    ));
  }

  void ResultModelBottomSheet(BuildContext ctx, ImageData SingleData, bool isEnabled) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200, // Adjust the height as needed
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    SingleData.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4D1F3E),
                      Color(0xFF08594C),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          SingleData.name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientButton(
                          width: 100,
                          height: 30,
                          onClick: () {
                            // Navigator.pop(context); // Close the modal
                            navigateToNewPage(context); // Call the navigation function
                          },
                          buttonText: "See",
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      SingleData.city,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      SingleData.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "There will be instances in your career when you will need a short and an extended, more in-depth bio. Write the long bio first, then pull out the essential parts to create the short bio – one to three paragraphs for the short one and three or more paragraphs for the long version. + ${SingleData.city}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Define a function to make the HTTP POST request and create the list of Location objects
  Future<void> sendPostRequest(BuildContext context, ImageData imageData, bool isEnabled) async {
    final apiUrl = Uri.parse('https://histomind-86f011d5789d.herokuapp.com/shortest-path');

    final data = {
      "user_id": LocationAndUserDataToPassedOBJECT.user_id,
      'latitude': LocationAndUserDataToPassedOBJECT.latitude,
      'longitude': LocationAndUserDataToPassedOBJECT.longitude,
      "destination_id": imageData.locationID,
      "distanceRadiusValue": LocationAndUserDataToPassedOBJECT.distanceRadiusValue,
      "updatedData": LocationAndUserDataToPassedOBJECT.updatedData,
    };

    print("Data to be sent:");
    print("UseriD is" + LocationAndUserDataToPassedOBJECT.user_id);
    print(data);

    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print("HTTP Response:");
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // Handle the successful response here
      final List<dynamic> responseData = jsonDecode(response.body);

      // // Create a list of Location objects from the response data
      List<Location> locations = responseData.map((locationData) {
        return Location.fromJson(locationData);
      }).toList();

      // print(locations);

      // Print the list of Location objects
      print("List of Location Objects:");
      locations.forEach((location) {
        print("ID: ${location.id}, Place: ${location.place}, Lat: ${location.lat}, Lon: ${location.lon}");

      });
      setRandomdummyLocations(locations);
      // Handle the isEnabled and ResultModelBottomSheet if needed
    } else {
      // Handle the error case if the response status code is not 200
    }
  }



  bool isEnabled=false;


  Future<void> _showImageDetails(
      BuildContext context, ImageData imageData, bool isEnabled) async {
    //TODO
    setState(() {
      ResultModelBottomSheet(context, imageData, isEnabled);
    });

    sendPostRequest(context,  imageData,  isEnabled);


    // setState(() {
    //   ResultModelBottomSheet(context, imageData);
    // });
  }

  @override
  Widget build(BuildContext context) {
    isDarkTheme = theme.brightness == Brightness.dark;
    double screenWidth = MediaQuery.of(context).size.width;
    // containerColor = theme.primaryColor.withOpacity(0.15);
    containerColor = Color(0xFFC8BFE7).withOpacity(0.6);

    List<ImageData> imageData = widget.settings.imageDataList;

    double widthRatio = widget.settings.widthRatio;
    double heightRatio = widget.settings.heightRatio;
    double elevation = widget.settings.elevation;
    // double marginRatio = widget.settings.marginRatio;
    double margin = widget.settings.margin;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * heightRatio,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: imageData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () => _showImageDetails(context, imageData[index], isEnabled),
              child: Container(
                width: MediaQuery.of(context).size.height * widthRatio,
                height: MediaQuery.of(context).size.height * heightRatio,
                margin: EdgeInsets.only(
                  // right: MediaQuery.of(context).size.width * marginRatio,
                  right: margin,
                ),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0, 0, 4, 8),
                  elevation: elevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height * widthRatio,
                        height: MediaQuery.of(context).size.height *
                            heightRatio *
                            8 /
                            10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10.0),
                          ),
                          child: Image.network(
                            imageData[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height * widthRatio,
                        height: MediaQuery.of(context).size.height *
                                heightRatio *
                                2 /
                                10 -
                            8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10.0),
                          ),
                          color: containerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

// // Calling this
// ImageCarousel(
// settings: settings02,
// ),
//
//
// // Settings
// final settings02 = ImageCarouselSettings(
//   imageDataList: [
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=8',
//       name: 'Photographer 8',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 8',
//     ),
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=9',
//       name: 'Photographer 9',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 9',
//     ),
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=10',
//       name: 'Photographer 10',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 10',
//     ),
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=11',
//       name: 'Photographer 11',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 11',
//     ),
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=12',
//       name: 'Photographer 12',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 12',
//     ),
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=13',
//       name: 'Photographer 13',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 13',
//     ),
//     ImageData(
//       imageUrl: 'https://picsum.photos/${imageResolution}/${imageResolution}?random=14',
//       name: 'Photographer 14',
//       dateTime: 'Daytime photography',
//       description: 'Description for photo 14',
//     ),
//   ],
//   widthRatio: Basic_Settings['widthRatio'],
//   heightRatio: Basic_Settings['heightRatio'],
//   elevation: Basic_Settings['elevation'],
//   marginRatio: Basic_Settings['marginRatio'],
//   initialPosition: 0.0,
//   margin: 16,
// );
