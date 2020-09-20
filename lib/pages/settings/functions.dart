import 'dart:convert';

import 'package:beauty_order_provider/constants/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<double>> getMyLocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return [position.latitude, position.longitude];
}

void urlLaunch({@required String url}) async {
  if (await canLaunch(url)) launch(url);
}
