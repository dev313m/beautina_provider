import 'package:flutter/material.dart';

class ModelUser {
  String doc_id; //this is mongodb doc 
  String _auth_id; //only for first login from firebase 
  String tokenId = ''; //This is the jwt token 
  String _phone;
  String _name;
  String _city;
  String _country;
  DateTime _reg_date;
  DateTime update_date;
  String email;
  String image;
  Map<String, dynamic> favorite_list;

  String _token;

  ModelUser(
      {@required String auth_id,
      @required String phone,
      String doc_id,
      String email,
      @required String name,
      @required String city,
      String tokenId,
      @required String token,
      @required String country,
      @required Map<String, dynamic> favorite_list,
      @required String image,
      @required DateTime update_date,
      @required DateTime reg_date})
      : this._city = city,
        this.doc_id = doc_id,
        this._country = country,
        this.tokenId = tokenId,
        this._name = name,
        this._phone = phone,
        this._token = token,
        this.email = email,
        this.update_date = update_date,
        this._reg_date = reg_date,
        this.image = image,
        this.favorite_list = favorite_list,
        this._auth_id = auth_id;

  Map<String, dynamic> toMap() {
    return {
      'doc_id': doc_id,
      'auth_id': auth_id,
      'city': _city,
      'email': email,
      'country': _country,
      'phone': _phone,
      'name': _name,
      'reg_date': _reg_date.toString(),
      'token': _token,
      'update_date': update_date.toString(),
      'image': image,
      'favorite_list': favorite_list,
      'tokenId': tokenId
    };
  }

  ModelUser.fromMap(Map<String, dynamic> data) {
    _auth_id = data['auth_id'];
    _city = data['city'];
    _country = data['country'];
    _name = data['name'];
    email = data['email'];
    _token = data['token'];
    _phone = data['phone'];
    _reg_date = DateTime.parse(data['reg_date']);
    doc_id = data['_id'] ?? data['doc_id']; // _id setup model from database, doc_id setup model from shared 
    update_date = DateTime.parse(data['update_date']);
    image = data['image'];
    favorite_list = data['favorite_list'] ?? {'salon':[],};
    tokenId = data['tokenId'];
  }

  DateTime get reg_date => _reg_date;

  set reg_date(DateTime reg_date) {
    _reg_date = reg_date;
  }

  String get token => _token;

  set token(String token) {
    _token = token;
  }

  String get country => _country;

  set country(String country) {
    _country = country;
  }

  String get city => _city;

  set city(String city) {
    _city = city;
  }

  String get auth_id => _auth_id;

  set auth_id(String auth_id) {
    _auth_id = auth_id;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  String get phone => _phone;

  set phone(String phone) {
    _phone = phone;
  }
}
