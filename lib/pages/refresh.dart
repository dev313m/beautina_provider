import 'package:beauty_order_provider/pages/dates/shared_variables_order.dart';
import 'package:beauty_order_provider/pages/my_salon/shared_mysalon.dart';
import 'package:beauty_order_provider/pages/root/shared_variable_root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

refreshApp(BuildContext context) {
  Provider.of<SharedRoot>(context).shareRoot();
  Provider.of<SharedSalon>(context).init();
  Provider.of<SharedOrder>(context).iniState();
}

refreshResume(BuildContext context) async {
  Provider.of<SharedOrder>(context).iniState();
  Provider.of<SharedRoot>(context).initNotificationDb();
}
