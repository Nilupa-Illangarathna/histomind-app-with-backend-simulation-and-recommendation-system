//
// //authenticcation of the user
// bool authenticated = false;
// String username = "";
// String password = "";
//
// //Variables
// // Current location related
// late double latitude;
// late double longitude;
// late String NearestLandmark;
//
// // Filters
// var DistanceRadiusValue;
//
// Map<String, String> updatedData = {
//   "Time Restrictions": "Not selected",
//   "Accessibility": "Not selected",
//   "Historical Contexts": "Not selected",
//   "Hands-On Activities": "Not selected"
// };




class LocationAndUserDataToPassed {
  // Authentication properties
  bool authenticated = false;
  String username = "";
  String password = "";
  String user_id = "";
  String email='';
  String name='';
  String local='';

  // Current location properties
  late double latitude;
  late double longitude;
  late String nearestLandmark;

  // Filters
  var distanceRadiusValue;

  Map<String, String> updatedData = {
    "Time Restrictions": "Not selected",
    "Accessibility": "Not selected",
    "Historical Contexts": "Not selected",
    "Hands-On Activities": "Not selected"
  };

  // Constructor
  LocationAndUserDataToPassed({
    this.authenticated = false,
    this.username = "",
    this.password = "",
    this.user_id = "",
    this.name='',
    this.email='',
    required this.latitude,
    required this.longitude,
    required this.nearestLandmark,
    this.distanceRadiusValue,
    required this.updatedData,
    required this.local,
  });

  // Method to print properties
  void printProperties() {
    print('Authentication: $authenticated');
    print('Username: $username');
    print('Password: $password');
    print('user id: $user_id');
    print('Latitude: $latitude');
    print('Longitude: $longitude');
    print('Nearest Landmark: $nearestLandmark');
    print('Distance Radius Value: $distanceRadiusValue');
    print('Distance Radius Value: $local');
    print('Updated Data:');

    updatedData.forEach((key, value) {
      print('$key: $value');
    });
  }

}



LocationAndUserDataToPassed LocationAndUserDataToPassedOBJECT = LocationAndUserDataToPassed(
  authenticated: false,
  username: "",
  password: "",
  user_id: "",
  latitude: 0.0,
  longitude: 0.0,
  nearestLandmark: "",
  distanceRadiusValue: 10.0,
  local: "en",
  updatedData: {
  "Time Restrictions": "Not selected",
  "Accessibility": "Not selected",
  "Historical Contexts": "Not selected",
  "Hands-On Activities": "Not selected"
},
);

//
// //authenticcation of the user
// bool authenticated = false;
// String username = "";
// String password = "";
//
// //Variables
// // Current location related
// late double latitude;
// late double longitude;
// late String NearestLandmark;
//
// // Filters
// var DistanceRadiusValue;
//
// Map<String, String> updatedData = {
//   "Time Restrictions": "Not selected",
//   "Accessibility": "Not selected",
//   "Historical Contexts": "Not selected",
//   "Hands-On Activities": "Not selected"
// };