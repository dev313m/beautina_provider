import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class VMSettingsData extends ChangeNotifier {
  RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> globalKey;

  bool _autoValidate = false;

  String _description;

  String _city;

  String _country;

  List<dynamic> _location;

  String _mobile;

  String _name;

  String _username;

  String get username => _username;

  set username(String username) {
    _username = username;
    notifyListeners();
  }

  VMSettingsData() {
    globalKey = GlobalKey<ScaffoldState>();
    formKey = GlobalKey<FormState>();
  }

  RoundedLoadingButtonController get controller => _controller;

  set controller(RoundedLoadingButtonController controller) {
    _controller = controller;
    notifyListeners();
  }

  List<dynamic> get location => _location;

  bool get autoValidate => _autoValidate;

  set autoValidate(bool autoValidate) {
    _autoValidate = autoValidate;
    notifyListeners();
  }

  String get country => _country;

  set country(String country) {
    _country = country;
    notifyListeners();
  }

  String get description => _description;

  set description(String description) {
    _description = description;
    notifyListeners();
  }

  String get city => _city;

  set city(String city) {
    _city = city;
    notifyListeners();
  }

  String get mobile => _mobile;

  set mobile(String mobile) {
    _mobile = mobile;
    notifyListeners();
  }

  String get name => _name;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set location(List<dynamic> location) {
    _location = location;
    notifyListeners();
  }
}
