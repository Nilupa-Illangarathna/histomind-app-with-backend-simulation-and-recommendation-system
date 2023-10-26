import '/Classes/dataPoints/drop_down_input_data.dart';
import 'package:flutter/material.dart';
import '/widgets/gradientButton/gradient_button.dart';
import '/Classes/Database/Database/shared_preferences_util.dart';
import '/widgets/DistanceAdjuster/Distance_Adjuster.dart';
import '/APICalls/Requests/LocationData.dart';



class MyDropdownForm extends StatefulWidget {
  @override
  _MyDropdownFormState createState() => _MyDropdownFormState();
}

class _MyDropdownFormState extends State<MyDropdownForm> {

  Future<void> loadSelectedValuesToFile() async {
    // DistanceRadiusValue = myVariable; //Saved
    // // Create a dictionary with "Not selected" for missing selections
    //
    LocationAndUserDataToPassedOBJECT.distanceRadiusValue = await SharedPreferencesDatabase.loadVariable("DistanceRadiusValueKey", 10.0);
    dropdownInputData.keys.forEach((key) async{
      LocationAndUserDataToPassedOBJECT.updatedData[key] = await SharedPreferencesDatabase.loadVariable(key, 'Not selected');
    });


    // For testing purposes, print the updated data
    print("Loaded data from the database is : ");
    print(LocationAndUserDataToPassedOBJECT.updatedData);
  }


  @override
  void initState() {
    super.initState();
    loadSelectedValuesToFile();
    setState(() {

    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSelectedValuesToFile();
  }


  // Initialize a dictionary to store selected values
  Map<String, String> selectedValues = {};

  // Create a function to build dropdowns dynamically
  List<Widget> buildDropdowns() {
    List<Widget> dropdowns = [];
    dropdownInputData.forEach((key, value) async {

      dropdowns.add(
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    key,
                    style: TextStyle(color: Colors.white),
                  )),
              Container(
                height: 45,
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20), // Rounded right corner
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Color(0xFF08594C)
                    ], // Gradient colors (left-to-right)
                  ),
                ),
                child: Container(
                  // width: 200, // Adjust the width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20), // Rounded left corner
                      right: Radius.circular(20), // Rounded right corner
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF4D1F3E).withOpacity(0.6),
                        Color(0xFF08594C).withOpacity(0.3)
                      ], // Gradient colors (left-to-right)
                    ),
                  ),
                  child: DropdownButtonFormField<String>(
                    onChanged: (newValue) {
                      setState(() {
                        selectedValues[key] = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      hintText: LocationAndUserDataToPassedOBJECT.updatedData[key] ?? 'Not selected',
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20), // Rounded left corner
                          right: Radius.circular(20), // Rounded right corner
                        ),
                        borderSide: BorderSide.none,
                      ),
                      labelText: LocationAndUserDataToPassedOBJECT.updatedData[key] ?? 'Not selected',
                      labelStyle:
                          TextStyle(color: Colors.transparent), // Label text style
                    ),
                    items: ['Not selected', ...value].map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(color: Colors.grey,fontSize: 14),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
    return dropdowns;
  }

  // Create a function to save selected values to a file
  void saveSelectedValuesToFile() {
    LocationAndUserDataToPassedOBJECT.distanceRadiusValue = LocationAndUserDataToPassedOBJECT.distanceRadiusValue; //Saved
    SharedPreferencesDatabase.saveVariable("DistanceRadiusValueKey", LocationAndUserDataToPassedOBJECT.distanceRadiusValue ?? 10.0);
    // Create a dictionary with "Not selected" for missing selections


    dropdownInputData.keys.forEach((key) async{
      LocationAndUserDataToPassedOBJECT.updatedData[key] = (selectedValues[key] ?? LocationAndUserDataToPassedOBJECT.updatedData[key]) ?? 'Not selected';
      SharedPreferencesDatabase.saveVariable(key, LocationAndUserDataToPassedOBJECT.updatedData[key] ?? 'Not selected');
      // print(key + "value loaded is " + await SharedPreferencesDatabase.loadVariable(key, 'Choose an option'));


    });





    // For testing purposes, print the updated data
    print(LocationAndUserDataToPassedOBJECT.updatedData);
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          //Distance selector
          RadiusSelector(
            initialValue: LocationAndUserDataToPassedOBJECT.distanceRadiusValue,
            minValue: 0,
            maxValue: 1000,
            onChanged: (value) {
              // Handle value change if needed
            },
            onSaved: (value) {
              // Save the changed value to a variable or perform other actions
              LocationAndUserDataToPassedOBJECT.distanceRadiusValue = value;
              print('Saved Radius: $value miles');
            },
          ),
          ...buildDropdowns(),
          SizedBox(height: 20),

          GradientButton(
            width: 150,
            height: 45,
            onClick: saveSelectedValuesToFile,
            buttonText: "Submit",
          ),
        ],
      ),
    );
  }
}
