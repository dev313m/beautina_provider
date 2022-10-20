import 'package:beautina_provider/blocks/settings_personal_info/block_settings_personal_info_repo.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/controller/erros_controller.dart';
import 'package:beautina_provider/core/db/location.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/picker.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:regexpattern/regexpattern.dart';

Future<List<double>> getMyLocation() async {
  Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return [position.latitude, position.longitude];
}

Future funUpdateUsername(String newUsername,
    RoundedLoadingButtonController roundedLoadingButtonController) async {
  if (!gFunValidateUsername(newUsername)) {
    showToast(
        'اسم المستخدم غير صالح، يجب ان يكون بالانجليزي وغير محتوي مسافات او بعض الرموز');
    roundedLoadingButtonController.error();
    await Future.delayed(Duration(seconds: 3));
    roundedLoadingButtonController.reset();
    return;
  }
  try {
    roundedLoadingButtonController.start();
    // setState(() {});

    await apiBeautyProviderUpdateUsername(newUsername);

    showToast('تم التحديث');
    roundedLoadingButtonController.success();
  } catch (e) {
    showToast(e.toString());
    ErrorController.logError(
        exception: e, eventName: BeautyProviderController.ErrUsername);
    roundedLoadingButtonController.error();
  }
  await Future.delayed(Duration(seconds: 3));
  roundedLoadingButtonController.reset();
  return;
}

void urlLaunch({required String url}) async {
  if (await canLaunch(url)) launch(url);
}

bool gFunValidateUsername(String username) {
  return username.isUsername();
}

Future updateBtn(BuildContext context,
    RoundedLoadingButtonController roundedLoadingButtonController,
    {phone, desc, name, city, country}) async {
  // if (!_validateInputs(context, settingsPersonalInfoUsecase)) return;

  /**
                         * 1- get now beautyProvider from shared
                         * 2- update and save in shared
                         * 3- get shared and notifylisteners
                         */

  //2
  ModelBeautyProvider newBeautyProvider = await getNewBeauty(
      name: name, descs: desc, mobile: phone, city: city, country: country);

  try {
    roundedLoadingButtonController.start();
    // setState(() {});
    Get.find<VMSalonDataTest>().beautyProvider =
        await apiBeautyProviderUpdate(newBeautyProvider);
    showToast('تم التحديث');
    roundedLoadingButtonController.success();
  } catch (e) {
    showToast('حدثت مشكلة، لم يتم التحديث');
    roundedLoadingButtonController.error();
    await Future.delayed(Duration(seconds: 3));
    roundedLoadingButtonController.reset();
    throw e;
  }
  await Future.delayed(Duration(seconds: 3));
  roundedLoadingButtonController.reset();
  return;
}

Future updateCountryCity(
    RoundedLoadingButtonController roundedLoadingButtonController,
    double lat,
    double lng) async {
  try {
    roundedLoadingButtonController.start();
    // setState(() {});

    await DBChangeLocation().updateLocation(lat: lat, lng: lng);
    BeautyProviderController().updateBeautyProviderProfile(
        BeautyProviderController.getBeautyProviderProfile()
          ..location = [lat, lng]);
    showToast('تم التحديث');
    roundedLoadingButtonController.success();
  } catch (e) {
    ErrorController.logError(
        exception: e, eventName: BeautyProviderController.Errlocation);
    showToast('حدثت مشكلة، لم يتم التحديث');
    roundedLoadingButtonController.error();
  }
  await Future.delayed(Duration(seconds: 3));
  roundedLoadingButtonController.reset();
  return;
}

bool _validateInputs(BuildContext context,
    SettingsPersonalInfoUsecase settingsPersonalInfoUsecase) {
  if (Get.find<VMSettingsDataTest>().formKey!.currentState!.validate()) {
//    If all data are correct then save data to out variables
    Get.find<VMSettingsDataTest>().formKey?..currentState!.save();
    return true;
  } else {
//    If all data are not valid then start auto validation.
    Get.find<VMSettingsDataTest>().autoValidate = true;
    return false;
  }
}

Future<ModelBeautyProvider> getNewBeauty(
    {name, mobile, descs, city, country}) async {
  ModelBeautyProvider bp = BeautyProviderController.getBeautyProviderProfile();
  var newBp = Get.find<VMSettingsDataTest>();
  bp.name = newBp.name ?? bp.name;
  bp.phone = newBp.mobile ?? bp.phone;
  bp.intro = newBp.description ?? bp.intro;
  bp.country = newBp.country ?? bp.country;
  bp.city = newBp.city ?? bp.city;

  return bp;
}

showMenuLocation(
    BuildContext context, GlobalKey<State<StatefulWidget>>? globalKey) {
  Function onConfirm() {
    VMSettingsDataTest vmSettingsData = Get.find<VMSettingsDataTest>();

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
String? validateName(String value) {
  if (value.length < 3)
    return errValidName;
  else
    return null;
}

///[todo valid phone characters]
String? validateMbile(String value) {
// Indian Mobile number are of 10 digit only
  // if(value.length==9)

  if (value.length != 9)
    return errValidPhone;
  else
    return null;
}

bool? checkValidPhoneChar(String number) {}

///[String]
const errValidName = 'Name must be more than 2 charater';
const errValidPhone = 'Mobile Number must be of 10 digit';
