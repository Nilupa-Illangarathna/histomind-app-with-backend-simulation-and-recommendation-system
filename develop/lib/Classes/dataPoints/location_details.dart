import 'dart:math';

class Location {
  final String id;
  final String place;
  final double lat;
  final double lon;

  Location({
    required this.id,
    required this.place,
    required this.lat,
    required this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['_id'] as String, // Assuming '_id' is a string in the JSON response
      place: json['name'] as String? ?? '', // Handle null value by providing a default empty string
      lat: json['latitude'] as double? ?? 0.0, // Handle null value by providing a default double value
      lon: json['longitude'] as double? ?? 0.0, // Handle null value by providing a default double value
    );
  }

}


//
List<Location> Locations3 = [
  Location(id: "0", place: "New York, USA", lat: 40.7128, lon: -74.0060),
  Location(id: "1", place: "Los Angeles, USA", lat: 34.0522, lon: -118.2437),
  Location(id: "2", place: "Chicago, USA", lat: 41.8781, lon: -87.6298),
  Location(id: "3", place: "San Francisco, USA", lat: 37.7749, lon: -122.4194),
  Location(id: "4", place: "Miami, USA", lat: 25.7617, lon: -80.1918),
  Location(id: "5", place: "Las Vegas, USA", lat: 36.1699, lon: -115.1398),

];


List<Location> dummyLocations = Locations3;

void setRandomdummyLocations(List<Location> pathMapfromAPI) {
  dummyLocations.forEach((location) {
    print("ID: ${location.id}, Place: ${location.place}, Lat: ${location.lat}, Lon: ${location.lon}");

  });
  dummyLocations = pathMapfromAPI;
  print(pathMapfromAPI);
  pathMapfromAPI.forEach((location) {
    print("ID: ${location.id}, Place: ${location.place}, Lat: ${location.lat}, Lon: ${location.lon}");

  });
}


List<Location> getRandomdummyLocations() {
  return dummyLocations;
  // return dummyLocations;
}

