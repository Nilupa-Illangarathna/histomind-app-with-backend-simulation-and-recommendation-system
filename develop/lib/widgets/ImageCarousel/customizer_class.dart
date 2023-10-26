class ImageData {
  final String imageUrl;
  final String name;
  final String city;
  final String description;
  final String locationID;
  final String opening_hours;

  ImageData({
    required this.imageUrl,
    required this.name,
    required this.city,
    required this.description,
    required this.locationID,
    required this.opening_hours,
  });


  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      description: json['description'] as String,
      locationID: json['_id'] as String,
      opening_hours: json['openTime'] + ' - ' + json['closeTime'],
    );
  }
}






class ImageCarouselSettings {
  List<ImageData> imageDataList;
  double widthRatio;
  double heightRatio;
  double elevation;
  double marginRatio;
  double initialPosition;
  double margin;

  ImageCarouselSettings({
    required this.imageDataList,
    required this.widthRatio,
    required this.heightRatio,
    required this.elevation,
    required this.marginRatio,
    required this.initialPosition,
    required this.margin,
  });

  // Method to set imageDataList
  void setImageDataList(List<ImageData> newDataList) {
    imageDataList = newDataList;
  }
}



// Basic Settings
Map<String, dynamic> Basic_Settings = {
  'widthRatio': 0.16,
  'heightRatio': 0.22,
  'elevation': 3.0,
  'marginRatio': 0.04,
  'margin':16,
};
