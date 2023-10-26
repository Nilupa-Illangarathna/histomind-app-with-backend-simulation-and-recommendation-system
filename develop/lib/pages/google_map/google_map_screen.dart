import 'package:flutter/material.dart';
import '/widgets/lenceFlare/lence_flare.dart';
import '/pages/custom_app_drawer/custom_app_drawer.dart';
import '/Classes/dataPoints/dashboard_location_label_string.dart';
import 'map_returner.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   actions: [],
        // ),
        drawer: CustomAppDrawer(),
        body: Stack(

          children: [
            LensFlareContainer(
              diameter: 200.0, // Specify the diameter
              color: Color(0xFF4D1F3E), // Specify the color
              x: MediaQuery.of(context).size.width * 1 / 6, // X-coordinate
              y: MediaQuery.of(context).size.height * 1 / 6, // Y-coordinate
              opacity: 1.0,
            ),
            LensFlareContainer(
              diameter: 120.0, // Specify the diameter
              color: Color(0xFF08594C), // Specify the color
              x: MediaQuery.of(context).size.width * 5 / 12, // X-coordinate
              y: MediaQuery.of(context).size.height * 5 / 12, // Y-coordinate
              opacity: 0.9,
            ),
            LensFlareContainer(
              diameter: 200.0, // Specify the diameter
              color: Color(0xFF08594C), // Specify the color
              x: MediaQuery.of(context).size.width * 2 / 12, // X-coordinate
              y: MediaQuery.of(context).size.height * 9 / 12, // Y-coordinate
              opacity: 0.5,
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) => RadialGradient(
                              center: Alignment.topCenter,
                              stops: [0.6, 1],
                              colors: [Color(0xFF4D1F3E), Color(0xFF08594C)],
                            ).createShader(bounds),
                            child: Icon(
                              Icons.pin_drop,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(LabelString.locationLabel,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Stack(
                          children: <Widget>[
                            new IconButton(
                                icon: new ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) =>
                                      RadialGradient(
                                        center: Alignment.topCenter,
                                        stops: [0.6, 1],
                                        colors: [
                                          Color(0xFF4D1F3E),
                                          Color(0xFF08594C)
                                        ],
                                      ).createShader(bounds),
                                  child: Icon(
                                    Icons.notifications,
                                  ),
                                ),
                                onPressed: () {}),
                            new Positioned(
                                child: new Stack(
                                  children: <Widget>[
                                    new Icon(Icons.brightness_1,
                                        size: 20.0, color: Colors.orange.shade500),
                                    new Positioned(
                                        top: 4.0,
                                        right: 5.0,
                                        child: new Center(
                                          child: new Text(
                                            "0",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ],
                                )),
                          ],
                        ),

                      ],
                    )

                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  color: Colors.transparent, // Set your desired background color here
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width * (7/10),
                        child: Text(
                          'My Routes',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                      ),
                      SizedBox(height: 38.0), // Add some space between text and button


                    ],
                  ),
                ),


                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        height: 100,
                        // width: 200,
                        child: CustomMap()
                    ),
                  ),
                ),
                SizedBox(height: 38.0),
              ],
            ),



          ],
        ),
      ),
    );
  }
}














