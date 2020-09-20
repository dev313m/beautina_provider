import 'package:beautina_provider/reusables/toast.dart';
import 'package:flutter/material.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class OrderFunctions {
  String infoStr = 'عدد الطلبات المنجزه: ';
  String cityStr = 'لمدينة: ';

  Future<String> submitFuction() async {
    await Future.delayed(Duration(seconds: 4));
    return 'تم تنفيذ الطلب بنجاح';
  }
}

getLaunchMapFunction(List<dynamic> geoPoint) {
  Function f = () async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${geoPoint[0]},${geoPoint[1]}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast('Could not launch $url');
    }
  };
  return f;
}

Function getWhatsappFunction(String s) {
  String url = 'tel://$s';

  String whatsappUrl = "whatsapp://send?phone=$s";

  Function f = () async {
    await canLaunch(whatsappUrl) ? launch(whatsappUrl) : launch(url);
  };
  // print('whatsapp');

  return f;
}
