import 'package:beautina_provider/chat/controller.dart';
import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/core/controller/beauty_provider_controller.dart';
import 'package:beautina_provider/core/controller/refresh_controller.dart';
import 'package:beautina_provider/core/main_init.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/refresh.dart';
import 'package:beautina_provider/screens/root/index.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/prefrences/services.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/picker.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:beautina_provider/services/api/api_provided_services.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:beautina_provider/services/auth/apple_auth.dart';
import 'package:beautina_provider/services/auth/auth.dart';
import 'package:beautina_provider/services/auth/google_auth.dart';
import 'package:beautina_provider/services/notification/token.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_picker/flutter_picker.dart';

SmsAuth smsAuth = SmsAuth();

loginWithApple(BuildContext? context) async {
  if (!isNameChosen(context)) throw Exception('الرجاء وضع الاسم');

  if (Get.find<VMLoginDataTest>().city == null) {
    throw Exception('الرجاء اختيار المنطقة');
  }
  if (Get.find<VMLoginDataTest>().accountType == -1) {
    throw Exception('الرجاء اختيار نوع الحساب');
  }
  // animationController.forward();
  smsAuth.phoneNum =
      Countries.phoneCode[Get.find<VMLoginDataTest>().city!.elementAt(0)!]! +
          Get.find<VMLoginDataTest>().phoneNum;

  // Function success = () {
  //   Get.find<VMLoginDataTest>().showCode = true;
  //   animationController.reverse();
  //   showToast('الرجاء ادراج الكود من الرساله');
  // };

  // Function error = () {
  //   animationController.reverse();
  //   showToast('حدث خطأ ما، الرجاء المحاولة لاحقا');
  // };
  // await smsAuth.verifyPhone(error, success);
  String? result;
  try {
    result = await signInWithApple();
    if (result == null)
      throw Exception("حدثت مشكله في التسجيل، الرجاء المحاولة مره اخرى");
    // showToast(result);
  } catch (e) {
    throw Exception(e.toString());
    // animationController.reverse();
  }
  if (result != null) await saveUserData(context);
}

loginWithGoogle(BuildContext? context) async {
  if (!isNameChosen(context)) throw Exception('الرجاء وضع الاسم');
  if (Get.find<VMLoginDataTest>().city == null) {
    throw Exception('الرجاء اختيار المنطقة');
  }
  if (Get.find<VMLoginDataTest>().accountType == -1) {
    throw Exception('الرجاء اختيار نوع الحساب');
  }
  // animationController.forward();
  smsAuth.phoneNum =
      Countries.phoneCode[Get.find<VMLoginDataTest>().city!.elementAt(0)!]! +
          Get.find<VMLoginDataTest>().phoneNum;

  // Function success = () {
  //   Get.find<VMLoginDataTest>().showCode = true;
  //   animationController.reverse();
  //   showToast('الرجاء ادراج الكود من الرساله');
  // };

  // Function error = () {
  //   animationController.reverse();
  //   showToast('حدث خطأ ما، الرجاء المحاولة لاحقا');
  // };
  // await smsAuth.verifyPhone(error, success);
  String? result;
  try {
    result = PlatformCheck.isWeb
        ? await signInWithGoogleWeb()
        : await signInWithGoogle();
    // showToast(result);
  } catch (e) {
    throw Exception(e.toString());
    // showToast();
    // animationController.reverse();
  }
  if (result != null) await saveUserData(context);
}

Function onConfirmPhoneNumber(BuildContext context) {
  Function f = (AnimationController animationController) async {
    if (!isNameChosen(context)) return () {};
    // animationController.forward();
    smsAuth.phoneNum =
        Countries.phoneCode[Get.find<VMLoginDataTest>().city!.elementAt(0)!]! +
            Get.find<VMLoginDataTest>().phoneNum;

    // Function success = () {
    //   Get.find<VMLoginDataTest>().showCode = true;
    //   animationController.reverse();
    //   showToast('الرجاء ادراج الكود من الرساله');
    // };

    // Function error = () {
    //   animationController.reverse();
    //   showToast('حدث خطأ ما، الرجاء المحاولة لاحقا');
    // };
    // await smsAuth.verifyPhone(error, success);
    String? result;
    try {
      result = await signInWithGoogle();
    } catch (e) {
      animationController.reverse();

      throw Exception(e.toString());
    }
    if (result != null) saveUserData(context);
  };
  return f;
}

Future<Null> saveUserData(BuildContext? context) async {
  // DocumentSnapshot userInfo = await apiUserCheckExist(currentUser.uid);

  try {
    final User currentUser = FirebaseAuth.instance.currentUser!;

    String? token = PlatformCheck.isWeb ? '' : await apiTokenGet();

    ModelBeautyProvider modelBeautyProvider =
        getUserData(currentUser.uid, token, context);
    modelBeautyProvider = await apiUserProviderAddNew(modelBeautyProvider);
    if (modelBeautyProvider == null)
      throw Exception('هناك خطأ');
    else {
      await BeautyProviderController().storeToLocalDB(modelBeautyProvider);
      await BeautyProviderController().storeToken(modelBeautyProvider.tokenId!);
      // await saveData(modelBeautyProvider);

      BeautyProviderController()
          .updateBeautyProviderProfile(modelBeautyProvider);
      await RefreshController.afterLogin();
      await ChatController().checkAndCreate();

      await sharedRegistered(true);

      routeToRoot(context!);
      await Future.delayed(Duration(seconds: 3));
      showToast('مرحبا بك في عالم الجمال');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

ModelBeautyProvider getUserData(
    String uid, String? token, BuildContext? context) {
  VMLoginDataTest signInData = Get.find<VMLoginDataTest>();
  String? country = Countries.countriesMap[signInData.city!.elementAt(0)!];
  String? city = Countries.citiesMap[signInData.city!.elementAt(1)!];

  return ModelBeautyProvider(
    available: true,
    city: city,
    type: signInData.accountType,
    country: country,
    phone: Countries.phoneCode[signInData.city!.elementAt(0)!]! +
        signInData.phoneNum,
    name: signInData.name,
    register_date: DateTime.now().toLocal(),
    token: token,
    firebase_uid: uid,
  );
}

Future<Null> saveData(ModelBeautyProvider modelBeautyProvider) async {
  await BeautyProviderController().storeToLocalDB(modelBeautyProvider);
  // await sharedUserProviderSet(beautyProvider: modelBeautyProvider);
  await saveAllServicesMapper();
}

saveAllServicesMapper() async {
  await memorySetServices(await apiProvidedServices());
}

routeToRoot(BuildContext context) {
  // refreshApp();
  Navigator.pushReplacement(context,
      PageTransition(type: PageTransitionType.fade, child: PageRoot()));
}

showPicker(BuildContext context, GlobalKey<State<StatefulWidget>> globalKey) {
  Function onConfirm() {
    return (Picker picker, List value) {
      Get.find<VMLoginDataTest>().city = [
        'السعوديه',
        picker.adapter.getSelectedValues().elementAt(0),
      ];
      // picker.adapter.getSelectedValues();
      // picker.getSelectedValues();
    };
  }

  cityPicker(onConfirm: onConfirm(), context: context);
}

saveName(BuildContext context, String name) {
  Get.find<VMLoginDataTest>().name = name;
}

bool isCityChosen(BuildContext context) {
  return Get.find<VMLoginDataTest>().city == null ? false : true;
}

String getCity(BuildContext context) {
  return Get.find<VMLoginDataTest>().city == null
      ? 'المدينة'
      : Get.find<VMLoginDataTest>().city!.elementAt(1).toString();
}

String getCountry(BuildContext context) {
  return Get.find<VMLoginDataTest>().city == null
      ? 'المنطقة'
      // : Get.find<VMLoginDataTest>().city.elementAt(1).toString();
      : "السعوديه";
}

String? getPhoneCode(BuildContext context) {
  VMLoginDataTest sp = Get.find<VMLoginDataTest>();
  return sp.city == null ? '' : Countries.phoneCode[sp.city!.elementAt(0)!];
}

bool isNameChosen(BuildContext? context) {
  VMLoginDataTest sp = Get.find<VMLoginDataTest>();

  if (sp.name == null || sp.name == '') {
    return false;
  }

  return true;
}
