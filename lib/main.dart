import 'package:beautina_provider/pages/dates/shared_variables_order.dart';
import 'package:beautina_provider/pages/my_salon/shared_mysalon.dart';
import 'package:beautina_provider/pages/root/index.dart';
import 'package:beautina_provider/pages/root/shared_variable_root.dart';
import 'package:beautina_provider/pages/signing_pages/index.dart';
import 'package:beautina_provider/prefrences/default_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_indicator/home_indicator.dart';
import 'package:provider/provider.dart';

void main() async {
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
              ChangeNotifierProvider<SharedRoot>(
                builder: (_) => SharedRoot(build: true),
              ),
              ChangeNotifierProvider<SharedOrder>(
                builder: (_) => SharedOrder(build: true),
              ),
              ChangeNotifierProvider<SharedSalon>(
                builder: (_) => SharedSalon(build: true),
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
              home: RootPage(),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<SharedRoot>(
                builder: (_) => SharedRoot(build: false),
              ),
              ChangeNotifierProvider<SharedSalon>(
                builder: (_) => SharedSalon(build: false),
              ),
              ChangeNotifierProvider<SharedOrder>(
                builder: (_) => SharedOrder(build: false),
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
              home: LoginPage(),
            ),
          );
  }
}
