import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '/APICalls/Requests/LocationData.dart';


void getLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    // Handle the case where the user denied permission
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  LocationAndUserDataToPassedOBJECT.latitude = position.latitude;
  LocationAndUserDataToPassedOBJECT.longitude = position.longitude;

  // Get the address or nearest landmark
  LocationAndUserDataToPassedOBJECT.nearestLandmark = (await getAddressFromCoordinates(LocationAndUserDataToPassedOBJECT.latitude, LocationAndUserDataToPassedOBJECT.longitude))!;

  // Do something with the latitude, longitude, and address
  print('Latitude: $LocationAndUserDataToPassedOBJECT.latitude, Longitude: $LocationAndUserDataToPassedOBJECT.longitude');
  print('Address: $LocationAndUserDataToPassedOBJECT.NearestLandmark');
}



Future<String?> getAddressFromCoordinates(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      String? address = placemark.name ?? placemark.thoroughfare;
      return address;
    }
  } catch (e) {
    print('Error getting address: $e');
  }
  return 'Address not found';
}
