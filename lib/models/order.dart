import 'package:flutter/material.dart';

class Order {
  String _doc_id;
  String _beauty_provider;

  ///order duration is calculated here in minutes
  ///and represents the duration to finish a specific order
  double order_duration;
  DateTime evaluation_date;
  double provider_response_time;
  String provider_notes;
  String _city;
  DateTime creation_data;
  String client_id;
  DateTime _client_cancel_date;
  List<dynamic> _client_location;
  DateTime _client_order_date;
  DateTime _client_submit_order_date;
  String _country;
  DateTime _finish_date;
  DateTime _provider_agree_date;
  List<dynamic> _provider_location;
  DateTime _provider_refuse_date;
  DateTime provider_cancel_date;
  Map<String, dynamic> _services;
  int _status;
  int _total_price;
  int _type;
  // Map<String, dynamic> _prices;
  String _client_phone;

  String _provider_phone;
  List<dynamic> _tokens;

  String _client_name;

  String _provider_name;

  String _order_info = '';

  int _who_come = 2;

  Order.fromMap(Map<String, dynamic> data) {
    client_id = data['client_id'];
    creation_data = data['creation_data'] == null ? null : DateTime.parse(data['creation_data']);
    evaluation_date = data['evaluation_date'] == null ? null : DateTime.parse(data['evaluation_date']);
    doc_id = data['_id'];
    order_duration = data['_order_duration'];
    provider_notes = data['provider_notes'] ?? '';

    beauty_provider = data['beauty_provider'];
    city = data['city'];
    client_cancel_date = data['client_cancel_date'] == null ? null : DateTime.parse(data['client_cancel_date']);
    client_location = data['client_location'];
    client_order_date = data['client_order_date'] == null ? null : DateTime.parse(data['client_order_date']);
    client_submit_order_date = data['client_submit_order_date'] == null ? null : DateTime.parse(data['client_submit_order_date']);
    country = data['country'];
    finish_date = data['finish_date'] == null ? null : DateTime.parse(data['finish_date']);
    client_phone = data['client_phone'];
    provider_phone = data['provider_phone'];
    provider_agree_date = data['provider_agree_date'] == null ? null : DateTime.parse(data['provider_agree_date']);
    provider_location = data['provider_location'];
    provider_refuse_date = data['provider_refuse_date'] == null ? null : DateTime.parse(data['provider_refuse_date']);
    client_name = data['client_name'];
    provider_name = data['provider_name'];
    tokens = data['tokens'];
    // services = snapshot.data['services'];
    services = data['services'];
    status = data['status'];
    total_price = data['total_price'];
    type = data['type'];
    who_come = data['who_come'];
    order_info = data['order_info'];
  }

  Order(
      {String doc_id,
      DateTime evaluation_date,
      @required String client_id,
      @required String beauty_provider,
      @required String city,
      @required DateTime creation_date,
      DateTime client_cancel_date,
      @required List<double> client_location,
      @required DateTime client_order_date,
      DateTime client_submit_order_date,
      @required String country,
      @required DateTime finish_date,
      DateTime provider_agree_date,
      double order_duration,
      @required List<dynamic> provider_location,
      DateTime provider_refuse_date,
      @required List<String> tokens,
      @required String client_name,
      @required String provider_name,
      @required Map<String, dynamic> services,
      @required int status,
      @required int total_price,
      @required int type,
      String provider_notes,
      // @required Map<String, dynamic> prices,
      @required String client_phone,
      @required String provider_phone,
      @required String order_info,
      @required int who_come})
      : this._doc_id = doc_id,
        this.evaluation_date = evaluation_date,
        this._beauty_provider = beauty_provider,
        this._city = city,
        this.order_duration = order_duration,
        this.creation_data = creation_date,
        this._client_cancel_date = client_cancel_date,
        this._client_location = client_location,
        this._client_order_date = client_order_date,
        this._client_submit_order_date = client_submit_order_date,
        this._country = country,
        this._finish_date = finish_date,
        this._provider_agree_date = provider_agree_date,
        this._provider_location = provider_location,
        this._provider_refuse_date = provider_refuse_date,
        this._services = services,
        this._status = status,
        this._total_price = total_price,
        this._type = type,
        this._client_phone = client_phone,
        this._provider_phone = provider_phone,
        this._provider_name = provider_name,
        this._client_name = client_name,
        this._tokens = tokens,
        this._who_come = who_come,
        this.provider_notes = provider_notes,
        this.client_id = client_id,
        this._order_info = order_info;

  Map<String, dynamic> getOrderMap() {
    Map<String, dynamic> map = {};
    map['_id'] = doc_id;
    map['creation_data'] = creation_data.toString();
    map['city'] = _city;
    map['provider_notes'] ?? provider_notes;
    if (provider_agree_date != null) map['provider_agree_date'] = provider_agree_date.toString();
    if (provider_refuse_date != null) map['provider_refuse_date'] = provider_refuse_date.toString();
    if (finish_date != null) map['finish_date'] = finish_date;
    map['evaluation_date'] = evaluation_date.toString();
    map['client_location'] = _client_location;
    map['client_order_date'] = _client_order_date.toString();
    map['country'] = _country;
    map['provider_phone'] = _provider_phone;
    map['client_phone'] = _client_phone;
    map['provider_location'] = _provider_location;
    map['tokens'] = _tokens;
    map['client_name'] = _client_name;
    map['provider_name'] = _provider_name;
    map['services'] = _services;
    map['status'] = _status;
    map['total_price'] = _total_price;
    map['type'] = _type;
    map['order_info'] = _order_info;
    map['who_come'] = _who_come;
    map['beauty_provider'] = _beauty_provider;
    map['finish_date'] = finish_date.toString();
    map['client_id'] = client_id;
    map['order_duration'] = order_duration;
    return map;
  }

  String get doc_id => _doc_id;

  set doc_id(String doc_id) {
    _doc_id = doc_id;
  }

  String get order_info => _order_info;

  set order_info(String order_info) {
    _order_info = order_info;
  }

  String get beauty_provider => _beauty_provider;

  set beauty_provider(String beauty_provider) {
    _beauty_provider = beauty_provider;
  }

  String get city => _city;

  set city(String city) {
    _city = city;
  }

  DateTime get client_cancel_date => _client_cancel_date;

  set client_cancel_date(DateTime client_cancel_date) {
    _client_cancel_date = client_cancel_date;
  }

  List<dynamic> get client_location => _client_location;

  set client_location(List<dynamic> client_location) {
    _client_location = client_location;
  }

  int get who_come => _who_come;

  set who_come(int who_come) {
    _who_come = who_come;
  }

  DateTime get client_order_date => _client_order_date;

  set client_order_date(DateTime client_order_date) {
    _client_order_date = client_order_date;
  }

  DateTime get client_submit_order_date => _client_submit_order_date;

  set client_submit_order_date(DateTime client_submit_order_date) {
    _client_submit_order_date = client_submit_order_date;
  }

  String get country => _country;

  set country(String country) {
    _country = country;
  }

  DateTime get finish_date => _finish_date;

  set finish_date(DateTime finish_date) {
    _finish_date = finish_date;
  }

  DateTime get provider_agree_date => _provider_agree_date;

  set provider_agree_date(DateTime provider_agree_date) {
    _provider_agree_date = provider_agree_date;
  }

  List<dynamic> get provider_location => _provider_location;

  set provider_location(List<dynamic> provider_location) {
    _provider_location = provider_location;
  }

  DateTime get provider_refuse_date => _provider_refuse_date;

  set provider_refuse_date(DateTime provider_refuse_date) {
    _provider_refuse_date = provider_refuse_date;
  }

  Map<String, dynamic> get services => _services;

  set services(Map<String, dynamic> services) {
    _services = services;
  }

  int get status => _status;

  set status(int status) {
    _status = status;
  }

  int get total_price => _total_price;

  set total_price(int total_price) {
    _total_price = total_price;
  }

  int get type => _type;

  set type(int type) {
    _type = type;
  }

  String get client_phone => _client_phone;

  set client_phone(String client_phone) {
    _client_phone = client_phone;
  }

  String get provider_phone => _provider_phone;

  set provider_phone(String provider_phone) {
    _provider_phone = provider_phone;
  }

  List<dynamic> get tokens => _tokens;

  set tokens(List<dynamic> tokens) {
    _tokens = tokens;
  }

  String get client_name => _client_name;

  set client_name(String client_name) {
    _client_name = client_name;
  }

  String get provider_name => _provider_name;

  set provider_name(String provider_name) {
    _provider_name = provider_name;
  }
}
