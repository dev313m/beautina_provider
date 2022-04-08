import 'package:get/get_state_manager/get_state_manager.dart';

class VMLoginDataTest extends GetxController {
  String _phoneNum = '';

  int accountType = -1; // 1 for salon
  String? _name;

  String? get name => _name;

  set name(String? name) {
    _name = name;
    update();
  }

  List<String?>? _city;

  List<String?>? get city => _city;

  set city(List<String?>? city) {
    _city = city;
    update();
  }

  String get phoneNum => _phoneNum;

  set phoneNum(String phoneNum) {
    _phoneNum = phoneNum;
    update();
  }

  String? _code;

  String? get code => _code;

  set code(String? code) {
    _code = code;
    update();
  }

  bool _showCode = false;

  bool get showCode => _showCode;

  set showCode(bool showCode) {
    _showCode = showCode;
    update();
  }
}
