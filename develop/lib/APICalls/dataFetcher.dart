// import 'dart:convert';
// import '/widgets/ImageCarousel/customizer_class.dart';
// import 'package:http/http.dart' as http;
//
// class DataFetcher {
//   Future<List<ImageData>> fetchArrayData(String baseUrl, String endpoint, String arrayName) async {
//     final response = await http.get(Uri.parse('$baseUrl$endpoint'));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final arrayData = data[arrayName] as List<dynamic>;
//       final typedArrayData = arrayData.map((item) =>ImageData.ImageDatafrom(item)).toList();
//       return typedArrayData;
//     } else {
//       throw Exception('Failed to fetch data from the server');
//     }
//   }
// }
