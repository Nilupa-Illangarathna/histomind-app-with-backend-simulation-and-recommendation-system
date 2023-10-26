import 'shared_preferences_util.dart';

int intVariable = 42;
double doubleVariable = 3.14;
String stringVariable = "Hello, World!";
bool boolVariable = true;



// Function to save multiple variables
Future<void> saveVariables() async {
  int intVariable1 = intVariable;
  double doubleVariable1 = doubleVariable;
  String stringVariable1 = stringVariable;
  bool boolVariable1 = boolVariable;

  await SharedPreferencesDatabase.saveVariable('intVariable1', intVariable1);
  await SharedPreferencesDatabase.saveVariable('doubleVariable', doubleVariable1);
  await SharedPreferencesDatabase.saveVariable('stringVariable', stringVariable1);
  await SharedPreferencesDatabase.saveVariable('boolVariable', boolVariable1);
}

// Function to load multiple variables with default values
Future<void> loadVariables() async {
  int loadedIntVariable = await SharedPreferencesDatabase.loadVariable('intVariable1', 0);
  double loadedDoubleVariable = await SharedPreferencesDatabase.loadVariable('doubleVariable', 0.0);
  String loadedStringVariable = await SharedPreferencesDatabase.loadVariable('stringVariable', '');
  bool loadedBoolVariable = await SharedPreferencesDatabase.loadVariable('boolVariable', false);

  print('Loaded intVariable1: $loadedIntVariable');
  print('Loaded doubleVariable: $loadedDoubleVariable');
  print('Loaded stringVariable: $loadedStringVariable');
  print('Loaded boolVariable: $loadedBoolVariable');
}

// incrementVariables
// Function to incrementVariables variables
Future<void> incrementVariables() async {
  intVariable +=2;
  doubleVariable +=2.0;
}

// decrementVariables
// Function to decrementVariables variables
Future<void> decrementVariables() async {
  intVariable -=1;
  doubleVariable -=1.0;
}