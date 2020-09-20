import 'package:beautina_provider/models/beauty_provider.dart';
import 'package:beautina_provider/models/order.dart';
import 'package:beautina_provider/prefrences/sharedUserProvider.dart';
import 'package:beautina_provider/services/api/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

final CANCEL_DATE_STATUS = 2;
final SUBMIT_STATUS = 3;
final AFTER_EVALUATION_STATUS = 6;

final POST_GET_URL =
    'https://app-beautyorder.uc.r.appspot.com/orders_beauty_provider';
final POST_GET_URL_CONFIRMED =
    'https://app-beautyorder.uc.r.appspot.com/orders_beauty_provider/getconfirmed';

final POST_REJECT_URL =
    'https://app-beautyorder.uc.r.appspot.com/orders_beauty_provider/reject';

final POST_ACCEPT_URL =
    'https://app-beautyorder.uc.r.appspot.com/orders_beauty_provider/accept';

final POST_FINISHED_INCOMPLETE =
    'https://app-beautyorder.uc.r.appspot.com/orders_beauty_provider/finished_incomplete';

final POST_FINISHED_COMPLETE =
    'https://app-beautyorder.uc.r.appspot.com/orders_beauty_provider/finished_complete';

final ERROR = 'حدث خطأ ما، الرجاء المحاولة مجددا';
Future<http.Response> apiOrderReject(Order order) async {
  http.Response response;
  ModelBeautyProvider user = await sharedUserProviderGetInfo();
  // Map<String, dynamic> obj = {
  //   "status": CANCEL_DATE_STATUS,
  //   'client_cancel_date': DateTime.now().toString(),
  //   'client_id': user.uid
  // };
  order.provider_refuse_date = DateTime.now().toUtc();
  PostHelper ph =
      PostHelper(auth: true, url: POST_REJECT_URL + "/${order.doc_id}");
  try {
    response = await ph.makePatchRequest(order.getOrderMap());
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
  } catch (e) {
    throw HttpException(ERROR);
  }
  return response;
}

Future<http.Response> apiOrderAccept(Order order) async {
  http.Response response;
  ModelBeautyProvider user = await sharedUserProviderGetInfo();
  // Map<String, dynamic> obj = {
  //   'client_cancel_date': DateTime.now().toString(),
  //   'client_id': user.uid
  // };
  order.provider_agree_date = DateTime.now().toUtc();
  PostHelper ph =
      PostHelper(auth: true, url: POST_ACCEPT_URL + "/${order.doc_id}");

  try {
    response = await ph.makePatchRequest(order.getOrderMap());
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
  } catch (e) {
    throw HttpException(ERROR);
  }
  return response;
}

Future<http.Response> apiFinishedIncomplete(Order order) async {
  http.Response response;
  ModelBeautyProvider user = await sharedUserProviderGetInfo();

  order.finish_date = DateTime.now().toUtc();
  PostHelper ph = PostHelper(
      auth: true, url: POST_FINISHED_INCOMPLETE + "/${order.doc_id}");
  try {
    response = await ph.makePatchRequest(order.getOrderMap());
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
  } catch (e) {
    throw HttpException(ERROR);
  }
  return response;
}

Future<http.Response> apiFinishedComplete(Order order) async {
  http.Response response;
  ModelBeautyProvider user = await sharedUserProviderGetInfo();
  order.finish_date = DateTime.now().toUtc();
  // Map<String, dynamic> obj = {
  //   'finish_date': DateTime.now().toUtc().toString(),
  //   'client_id': user.uid
  // };
  PostHelper ph =
      PostHelper(auth: true, url: POST_FINISHED_COMPLETE + "/${order.doc_id}");
  try {
    response = await ph.makePatchRequest(order.getOrderMap());
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
  } catch (e) {
    throw HttpException(ERROR);
  }
  return response;
}

List<Order> parse(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Order>((json) => Order.fromMap(json)).toList();
}

Future<List<Order>> getOrders(
    {@required int day = 0, @required int month}) async {
  ModelBeautyProvider user = await sharedUserProviderGetInfo();
  PostHelper ph = PostHelper(auth: true, url: POST_GET_URL);
  DateTime now = DateTime.now();
  now = DateTime(now.year, now.month, now.day);
  DateTime from;
  DateTime to;
  if (day != 0) {
    from = now;
    to = DateTime(now.year, month + 1, 1)..subtract(Duration(days: 1));
  } else {
    from = DateTime(now.year, month, 1);

    to = DateTime(now.year, from.month + 1, 1)..subtract(Duration(days: 1));
  }

  try {
    http.Response response = await ph.makePostRequest(
        {'from': from.toString(), 'to': to.toString(), 'id': user.uid});
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
    return parse(response.body);
  } catch (e) {
    throw HttpException(ERROR);
  }
}

Future<List<Order>> getComingConfirmed() async {
  ModelBeautyProvider user = await sharedUserProviderGetInfo();
  PostHelper ph = PostHelper(auth: true, url: POST_GET_URL_CONFIRMED);
  DateTime now = DateTime.now();
  now = DateTime(now.year, now.month, now.day);

  try {
    http.Response response =
        await ph.makePostRequest({'from': now.toString(), 'id': user.uid});
    if (response.statusCode != 200)
      throw HttpException(jsonDecode(response.body)['message']);
    return parse(response.body);
  } catch (e) {
    throw HttpException(ERROR);
  }
}
