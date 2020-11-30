import 'package:beautina_provider/screens/dates/vm/vm_data.dart';
import 'package:beautina_provider/screens/salon/vm/vm_salon_data.dart';
import 'package:beautina_provider/screens/root/vm/vm_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

refreshApp(BuildContext context) {
  Provider.of<VMRootData>(context).shareRoot();
  Provider.of<VMSalonData>(context).init();
  Provider.of<VmDateData>(context).iniState();
}

refreshResume(BuildContext context) async {
  Provider.of<VmDateData>(context).iniState();
  Provider.of<VMRootData>(context).initNotificationDb();
}
