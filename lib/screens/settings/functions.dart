import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/picker.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

Future<List<double>> getMyLocation() async {
  Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return [position.latitude, position.longitude];
}

void urlLaunch({@required String url}) async {
  if (await canLaunch(url)) launch(url);
}

Future updateBtn(BuildContext context,RoundedLoadingButtonController roundedLoadingButtonController ) async {
 
  if (!_validateInputs(context)) return;
  /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */

  //2
  ModelBeautyProvider newBeautyProvider = await getNewBeauty(context);

  try {
    roundedLoadingButtonController.start();
    // setState(() {});
    Provider.of<VMSalonData>(context).beautyProvider =
        await apiBeautyProviderUpdate(newBeautyProvider);
    showToast('تم التحديث');
    roundedLoadingButtonController.success();
  } catch (e) {
    showToast('حدثت مشكلة، لم يتم التحديث');
    roundedLoadingButtonController.error();
  }
  await Future.delayed(Duration(seconds: 3));
  roundedLoadingButtonController.reset();
  return;
}

bool _validateInputs(BuildContext context) {
  if (Provider.of<VMSettingsData>(context).formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
    Provider.of<VMSettingsData>(context).formKey..currentState.save();
    return true;
  } else {
//    If all data are not valid then start auto validation.
    Provider.of<VMSettingsData>(context).autoValidate = true;
    return false;
  }
}

Future<ModelBeautyProvider> getNewBeauty(BuildContext context) async {
  VMSettingsData vmSettingsData = Provider.of<VMSettingsData>(context);
  ModelBeautyProvider bp = await sharedUserProviderGetInfo();

  bp.name = vmSettingsData.name ?? bp.name;
  bp.phone = vmSettingsData.mobile ?? bp.phone;
  bp.intro = vmSettingsData.description ?? bp.intro;
  bp.location = vmSettingsData.location ?? bp.location;
  bp.city = vmSettingsData.city ?? bp.city;
  bp.country = vmSettingsData.country ?? bp.country;

  return bp;
}

showMenuLocation(
    BuildContext context, GlobalKey<State<StatefulWidget>> globalKey) {
  Function onConfirm() {
    VMSettingsData vmSettingsData = Provider.of<VMSettingsData>(context);

    return (Picker picker, List value) {
      // Provider.of<VMLoginData>(context).city =
      //     picker.adapter.getSelectedValues();
      // picker.getSelectedValues();

      vmSettingsData.country = Countries.countriesMap['السعوديه'];
      // _country =
      //     Countries.countriesMap[picker.adapter.getSelectedValues()[0]];
      vmSettingsData.city =
          Countries.citiesMap[picker.adapter.getSelectedValues().elementAt(0)];
      // print(picker.getSelectedValues().toString());
    };
  }

  cityPicker(onConfirm: onConfirm(), context: context);
}

///Valid name is more than three char
String validateName(String value) {
  if (value.length < 3)
    return errValidName;
  else
    return null;
}

///[todo valid phone characters]
String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  // if(value.length==9)

  if (value.length != 9)
    return errValidPhone;
  else
    return null;
}

bool checkValidPhoneChar(String number) {}

///[String]
const errValidName = 'Name must be more than 2 charater';
const errValidPhone = 'Mobile Number must be of 10 digit';
