import 'package:beautina_provider/screens/chat_pages/rooms/vm/vm_chats_data.dart';
import 'package:beautina_provider/screens/dates/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui_test.dart';
import 'package:beautina_provider/screens/root/index.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data_test.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data_test.dart';
import 'package:beautina_provider/screens/signing_pages/index.dart';
import 'package:beautina_provider/screens/signing_pages/vm/vm_login_data_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';

void main() async {
  //just be aware here.
  WidgetsFlutterBinding.ensureInitialized();

  bool registered = await sharedGetRegestered();
  // await sharedRegistered(true);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('user_info',  '{"type":1,"service_duration":{"hc01":15,"تست":15,"hca01":60,"hs01":15,"wa01":300,"hs05":150,"wa03":60,"test":120,"bb01":60},"default_after_accept":2,"available":false,"auth_login":"","tokenId":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwMDgxNDRmN2EyOWYzMDAwYTM4MTBiZCIsImVtYWlsIjoicmFzYXNpLmJAZ21haWwuY29tIiwiaWF0IjoxNjE1ODI4NTY1fQ.4D-YhG_gD8fRCpLTdH33O3NqO_yqqB_g2ykv9WNKjOg","default_accept":false,"image":"","package":{},"busy_dates":[],"username":"good_d","customers":2.0,"acheived":0,"intro":"jklsjfdlkjfsldkfj lsdkjfdls jfdslkf jdslf djl ","favorite_count":2,"location":[37.4219983,-122.084],"name":"test","visitors":0,"points":0,"reg_date":"2021-01-20 14:30:17.240Z","rating":9.0,"phone":"+966433333333","city":"Mekkah","country":"SA","voter":3,"email":"rasasi.b@gmail.com","likes":0,"achieved":0,"services":{"hair_cut":{},"hair_style":{"hs05":[90]},"wax":{"wa03":[40]},"other":{"test":[90]},"henna_red":{}},"token":"dC36J0sbKr4:APA91bEu4Myr1HToXAf2AmiOXuYZii7MRd_x2mdS2vYdaJ6vb-77m7V72Kz4DVyScIZfOwextqA3A_W1sSF_P_Wd3ErY8Q4twCEgaZvgaOeDEYgtE5BrniaX0Jj1_5QKlnljdWhEUNv7","_id":"6008144f7a29f3000a3810bd"}'
// );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  // FullScreen fullscreen = FullScreen();

  // await HomeIndicator.hide();

  return runApp(MyApp(
    registered: registered,
  ));
}

class MyApp extends StatelessWidget {
  final registered;
  const MyApp({this.registered});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding:
            getBinding(),
        theme: ThemeData(
          fontFamily: ArabicFonts.Tajawal,
        ),
        home: registered != null ? PageRoot() : LoginPage());
  }

   Bindings getBinding(){
    if(registered!=null)
    return InitialBindingRegistered(); 
    return InitialBinding(); 
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: false), permanent: true);
    Get.put(VmDateDataTest(build: false));
    Get.put(VMSettingsDataTest(), permanent: true);
    Get.put(VMLoginDataTest(), permanent: true);
    Get.lazyPut<VMChatRooms>(() {
      return VMChatRooms();
    }, fenix: true);
    Get.put(VMSalonDataTest(build: false), permanent: true);
  }
}

class InitialBindingRegistered extends Bindings {
  @override
  void dependencies() {
    Get.put(VMRootUiTest(), permanent: true);
    Get.put(VMRootDataTest(build: true), permanent: true);
    Get.put(VmDateDataTest(build: true));
    Get.put(VMSettingsDataTest(), permanent: true);
        Get.lazyPut<VMChatRooms>(() {
      return VMChatRooms();
    }, fenix: true);
    Get.put(VMSalonDataTest(build: true), permanent: true);
  }
}
