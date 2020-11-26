import 'package:beautina_provider/screens/dates/shared_variables_order.dart';
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
                builder: (_) => VMRootData(build: true),
              ),
              ChangeNotifierProvider<VMRootUi>(
                builder: (_) => VMRootUi(),
              ),
              ChangeNotifierProvider<SharedOrder>(
                builder: (_) => SharedOrder(build: true),
              ),
              ChangeNotifierProvider<VMSalonData>(
                builder: (_) => VMSalonData(build: true),
              ),
              ChangeNotifierProvider<VMSettingsData>(
                builder: (_) => VMSettingsData(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              home: PageRoot(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<VMRootData>(
                builder: (_) => VMRootData(build: false),
              ),
              ChangeNotifierProvider<VMRootUi>(
                builder: (_) => VMRootUi(),
              ),
              ChangeNotifierProvider<VMSalonData>(
                builder: (_) => VMSalonData(build: false),
              ),
              ChangeNotifierProvider<SharedOrder>(
                builder: (_) => SharedOrder(build: false),
              ),
              ChangeNotifierProvider<VMSettingsData>(
                  create: (_) => VMSettingsData())
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              home: LoginPage(),
            ),
          );
  }
}
