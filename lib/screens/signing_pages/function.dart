import 'dart:convert';

import 'package:beautina_provider/constants/countries.dart';
import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/screens/refresh.dart';
import 'package:beautina_provider/screens/root/index.dart';
import 'package:beautina_provider/screens/signing_pages/shared_variable.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/prefrences/services.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/reusables/picker.dart';
import 'package:beautina_provider/reusables/toast.dart';
import 'package:beautina_provider/services/api/api_provided_services.dart';
import 'package:beautina_provider/services/api/api_user_provider.dart';
import 'package:beautina_provider/services/auth/apple_auth.dart';
import 'package:beautina_provider/services/auth/auth.dart';
import 'package:beautina_provider/services/auth/google_auth.dart';
import 'package:beautina_provider/services/notification/token.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_picker/flutter_picker.dart';

SmsAuth smsAuth = SmsAuth();

loginWithApple(BuildContext context) async {
  if (!isNameChosen(context)) return;
  if (Provider.of<SignInSharedVariable>(context).city == null) {
    throw Exception('الرجاء اختيار المنطقة');
  }
  if (Provider.of<SignInSharedVariable>(context).accountType == -1) {
    throw Exception('الرجاء اختيار نوع الحساب');
  }
  // animationController.forward();
  smsAuth.phoneNum = Countries.phoneCode[
          Provider.of<SignInSharedVariable>(context).city.elementAt(0)] +
      Provider.of<SignInSharedVariable>(context).phoneNum;

  // Function success = () {
  //   Provider.of<SignInSharedVariable>(context).showCode = true;
  //   animationController.reverse();
  //   showToast('الرجاء ادراج الكود من الرساله');
  // };

  // Function error = () {
  //   animationController.reverse();
  //   showToast('حدث خطأ ما، الرجاء المحاولة لاحقا');
  // };
  // await smsAuth.verifyPhone(error, success);
  String result;
  try {
    result = await signInWithApple();
    // showToast(result);
  } catch (e) {
    showToast(e.toString());
    // animationController.reverse();
  }
  if (result != null) await saveUserData(context);
}

loginWithGoogle(BuildContext context) async {
  if (!isNameChosen(context)) return;
  if (Provider.of<SignInSharedVariable>(context).city == null) {
    throw Exception('الرجاء اختيار المنطقة');
  }
  if (Provider.of<SignInSharedVariable>(context).accountType == -1) {
    throw Exception('الرجاء اختيار نوع الحساب');
  }
  // animationController.forward();
  smsAuth.phoneNum = Countries.phoneCode[
          Provider.of<SignInSharedVariable>(context).city.elementAt(0)] +
      Provider.of<SignInSharedVariable>(context).phoneNum;

  // Function success = () {
  //   Provider.of<SignInSharedVariable>(context).showCode = true;
  //   animationController.reverse();
  //   showToast('الرجاء ادراج الكود من الرساله');
  // };

  // Function error = () {
  //   animationController.reverse();
  //   showToast('حدث خطأ ما، الرجاء المحاولة لاحقا');
  // };
  // await smsAuth.verifyPhone(error, success);
  String result;
  try {
    result = await signInWithGoogle();
    // showToast(result);
  } catch (e) {
    showToast(e.toString());
    // animationController.reverse();
  }
  if (result != null) await saveUserData(context);
}

Function onConfirmPhoneNumber(BuildContext context) {
  Function f = (AnimationController animationController) async {
    if (!isNameChosen(context)) return () {};
    // animationController.forward();
    smsAuth.phoneNum = Countries.phoneCode[
            Provider.of<SignInSharedVariable>(context).city.elementAt(0)] +
        Provider.of<SignInSharedVariable>(context).phoneNum;

    // Function success = () {
    //   Provider.of<SignInSharedVariable>(context).showCode = true;
    //   animationController.reverse();
    //   showToast('الرجاء ادراج الكود من الرساله');
    // };

    // Function error = () {
    //   animationController.reverse();
    //   showToast('حدث خطأ ما، الرجاء المحاولة لاحقا');
    // };
    // await smsAuth.verifyPhone(error, success);
    String result;
    try {
      result = await signInWithGoogle();
    } catch (e) {
      showToast(e.toString());
      animationController.reverse();
    }
    if (result != null) saveUserData(context);
  };
  return f;
}

// Function onConfirmCodeNumber(BuildContext context) {
//   Function f = (AnimationController animationController) async {
//     animationController.forward();
//     smsAuth.codeNum = Provider.of<SignInSharedVariable>(context).code;
//     bool status = await smsAuth.signInWithPhoneNumber();
//     if (!status)
//       showToast('هناك خطأ، الرجاء وضع الرقم الصحيح');
//     else {
//       //Todo do add to firebase the user
//       await saveUserData(context);
//       routeToRoot(context);
//     }
//     animationController.reverse();
//   };
//   return f;
// }
// Function onConfirmCodeNumber(BuildContext context) {
//   Function f = (AnimationController animationController) async {
//     animationController.forward();
//     smsAuth.codeNum = Provider.of<SignInSharedVariable>(context).code;
//     bool status = await smsAuth.signInWithPhoneNumber();
//     if (!status)
//       showToast('هناك خطأ، الرجاء وضع الرقم الصحيح');
//     else {
//       //Todo do add to firebase the user
//       await saveUserData(context);
//       routeToRoot(context);
//     }
//     animationController.reverse();
//   };
//   return f;
// }

Future<Null> saveUserData(BuildContext context) async {
  // DocumentSnapshot userInfo = await apiUserCheckExist(currentUser.uid);

  try {
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    String token = await apiTokenGet();

    ModelBeautyProvider modelBeautyProvider =
        getUserData(currentUser.uid, token, context);
    modelBeautyProvider = await apiUserProviderAddNew(modelBeautyProvider);
    if (modelBeautyProvider == null)
      showToast('هناك خطأ');
    else {
      await saveData(modelBeautyProvider);
      showToast('مرحبا بك في عالم الجمال');
      await sharedRegistered(true);
      routeToRoot(context);
    }
  } catch (e) {
    showToast(e.toString());
  }
}

ModelBeautyProvider getUserData(
    String uid, String token, BuildContext context) {
  SignInSharedVariable signInData = Provider.of<SignInSharedVariable>(context);
  String country = Countries.countriesMap[signInData.city.elementAt(0)];
  String city = Countries.citiesMap[signInData.city.elementAt(1)];

  return ModelBeautyProvider(
    available: true,
    city: city,
    type: signInData.accountType,
    country: country,
    username:
        Countries.phoneCode[signInData.city.elementAt(0)] + signInData.phoneNum,
    name: signInData.name,
    register_date: DateTime.now().toLocal(),
    token: token,
    auth_login: uid,
  );
}

Future<Null> saveData(ModelBeautyProvider modelBeautyProvider) async {
  await sharedUserProviderSet(beautyProvider: modelBeautyProvider);
  await saveAllServicesMapper();
}

saveAllServicesMapper() async {
  await memorySetServices(await apiProvidedServices());
}

routeToRoot(BuildContext context) {
  refreshApp(context);
  Navigator.pushReplacement(context,
      PageTransition(type: PageTransitionType.fade, child: RootPage()));
}

showPicker(BuildContext context, GlobalKey<State<StatefulWidget>> globalKey) {
  Function onConfirm() {
    return (Picker picker, List value) {
      Provider.of<SignInSharedVariable>(context).city = [
        'السعوديه',
        picker.adapter.getSelectedValues().elementAt(0),
      ];
      // picker.adapter.getSelectedValues();
      // picker.getSelectedValues();
    };
  }

  cityPicker(onConfirm: onConfirm(), context: context);

  // Picker picker = Picker(
  //     adapter: PickerDataAdapter<String>(
  //         pickerdata: JsonDecoder().convert(Countries.countriesList)),
  //     changeToFirst: true,
  //     cancelText: 'عودة',
  //     confirmText: 'تأكيد',
  //     textAlign: TextAlign.left,
  //     textStyle: const TextStyle(color: Colors.blue),
  //     selectedTextStyle: TextStyle(color: Colors.red),
  //     columnPadding: const EdgeInsets.all(8.0),
  //     onConfirm: (Picker picker, List value) {
  //       Provider.of<SignInSharedVariable>(context).city =
  //           picker.adapter.getSelectedValues();
  //       // picker.getSelectedValues();
  //       print(picker.getSelectedValues().toString());
  //     });
  // picker.show(globalKey.currentState);
}

saveName(BuildContext context, String name) {
  Provider.of<SignInSharedVariable>(context).name = name;
}

bool isCityChosen(BuildContext context) {
  return Provider.of<SignInSharedVariable>(context).city == null ? false : true;
}

String getCity(BuildContext context) {
  return Provider.of<SignInSharedVariable>(context).city == null
      ? 'المدينة'
      : Provider.of<SignInSharedVariable>(context).city.elementAt(1).toString();
}

String getCountry(BuildContext context) {
  return Provider.of<SignInSharedVariable>(context).city == null
      ? 'المنطقة'
      // : Provider.of<SignInSharedVariable>(context).city.elementAt(1).toString();
      : "السعوديه";
}

String getPhoneCode(BuildContext context) {
  SignInSharedVariable sp = Provider.of<SignInSharedVariable>(context);
  return sp.city == null ? '' : Countries.phoneCode[sp.city.elementAt(0)];
}

bool isNameChosen(BuildContext context) {
  SignInSharedVariable sp = Provider.of<SignInSharedVariable>(context);

  if (sp.name == null || sp.name == '') {
    showToast('الرجاء وضع الاسم');
    return false;
  }

  return true;
}
