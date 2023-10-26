import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/Classes/dataPoints/location_details.dart';

class CustomMap extends StatefulWidget {
  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  GoogleMapController? _mapController;
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }
  List<Location> dummyLocations = getRandomdummyLocations();
  void _initializeMap() {
    markers = dummyLocations
        .map(
          (location) => Marker(
        markerId: MarkerId(location.id.toString()),
        position: LatLng(location.lat, location.lon),
        infoWindow: InfoWindow(title: location.place),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(dummyLocations.first.lat, dummyLocations.first.lon),
          zoom: 12.0,
        ),
        markers: Set.from(markers),
        polylines: _buildPolylines(),
      ),
    );
  }

  Set<Polyline> _buildPolylines() {
    List<LatLng> locations =
    dummyLocations.map((location) => LatLng(location.lat, location.lon)).toList();
    Set<Polyline> polylines = {};

    for (int i = 0; i < locations.length - 1; i++) {
      Polyline polyline = Polyline(
        polylineId: PolylineId('route$i'),
        color: Color(0xFF4D1F3E).withOpacity(0.7),
        points: [locations[i], locations[i + 1]],
        width: 7,
      );

      polylines.add(polyline);
    }

    return polylines;
  }
}
