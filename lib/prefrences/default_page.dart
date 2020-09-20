import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Checking, setting  the type of the profile
Future sharedRegistered(bool b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('page', b); //True is for employee
  return;
}

Future<bool> sharedGetRegestered() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('page'); //False is for employer
}
