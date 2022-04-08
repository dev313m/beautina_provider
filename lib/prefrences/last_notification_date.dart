import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

//Checking, setting  the type of the profile
Future setPrefrenceLastNotifyDate(String b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('notify_date', b); //True is for employee
}

Future<String?> getPrefrenceLastNotifyDate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('notify_date'); //False is for employer
}
