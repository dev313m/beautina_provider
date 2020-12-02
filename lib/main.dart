import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/root/index.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_ui.dart';
import 'package:beautina_provider/screens/settings/vm/vm_data.dart';
import 'package:beautina_provider/screens/signing_pages/index.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_indicator/home_indicator.dart';
import 'package:provider/provider.dart';

void main() async {
  //just be aware here.
  WidgetsFlutterBinding.ensureInitialized();

  bool registered = await sharedGetRegestered();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black));
  await HomeIndicator.hide();

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
    return registered != null
        ? MultiProvider(
            providers: [
              ChangeNotifierProvider<VMRootData>(
                create: (_) => VMRootData(build: true),
              ),
              ChangeNotifierProvider<VMRootUi>(
                create: (_) => VMRootUi(),
              ),
              ChangeNotifierProvider<VmDateData>(
                create: (_) => VmDateData(build: true),
              ),
              ChangeNotifierProvider<VMSalonData>(
                create: (_) => VMSalonData(build: true),
              ),
              ChangeNotifierProvider<VMSettingsData>(
                create: (_) => VMSettingsData(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: PageRoot(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<VMRootData>(
                create: (_) => VMRootData(build: false),
              ),
              ChangeNotifierProvider<VMRootUi>(
                create: (_) => VMRootUi(),
              ),
              ChangeNotifierProvider<VMSalonData>(
                create: (_) => VMSalonData(build: false),
              ),
              ChangeNotifierProvider<VmDateData>(
                create: (_) => VmDateData(build: false),
              ),
              ChangeNotifierProvider<VMSettingsData>(
                  create: (_) => VMSettingsData())
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginPage(),
            ),
          );
  }
}
