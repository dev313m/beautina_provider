import 'dart:convert';

/**
 * This class is a model for the type Prefrence
 */

class ModelBeautyProvider {
  static int TYPE_SALON = 1;
  static int TYPE_INDIVIDUAL = 1;
  List<Map<String, DateTime>> busyDates =
      []; // Date that provider is not available for order
  int type; //whether it was a salon or a simple woman 1 for salon
  bool _available;
  String _image;
  double customers;
  String _intro;
  String email;
  Map<String,dynamic> service_duration; 
  List<dynamic> _location;
  String _name;
  int _voter;
  String username;
  String _uid = '';
  String tokenId; // this is the jwt token for authority
  int _achieved;
  String auth_login; // only one time firebase token for login
  String _city;
  int _points;
  int favorite_count;
  int visitors;
  DateTime _register_date;
  double _rating;
  Map<String, dynamic> package;
  Map<String, dynamic> servicespro;

  String _phone;
  String _token; // notification token

  String _country;
  int _likes;

  String get token => _token;

  set token(String token) {
    _token = token;
  }

  String get uid => _uid;

  set uid(String uid) {
    _uid = uid;
  }

  int get achieved => _achieved;

  set achieved(int achieved) {
    _achieved = achieved;
  }

  int get voter => _voter;

  set voter(int voter) {
    _voter = voter;
  }

  String get city => _city;

  set city(String city) {
    _city = city;
  }

  int get likes => _likes;

  set likes(int likes) {
    _likes = likes;
  }

  String get country => _country;

  set country(String country) {
    _country = country;
  }

  ModelBeautyProvider.empty();

  ModelBeautyProvider(
      {Map<String, dynamic> prices,
      List<dynamic> location,
      bool available,
      String image,
      int type,
      String email,
      String token,
      Map<String, dynamic> package,
      String intro,
      String name,
      double customers,
      int points,
        Map<String,int> service_duration,

      String tokenId,
      List<Map<String, DateTime>> busyDates,
      int favorite_count,
      String auth_login,
      double rating,
      DateTime register_date,
      int voter,
      String country,
      int likes,
      int visitors,
      String city,
      String uid,
      String username,
      int achieved,
      Map<String, List<dynamic>> services,
      String phone})
      : this._location = location,
        this._name = name,
        this.email = email,
        this.visitors = visitors,
        this.username = username,
        this.package = package,
        this.favorite_count = favorite_count,
        this._points = points,
        this.type = type,
        this.busyDates = busyDates,
        this.tokenId = tokenId,
        this.customers = customers,
        this._rating = rating,
          this. service_duration = service_duration, 

        this.auth_login = auth_login,
        this._phone = phone,
        this._available = available,
        this._image = image,
        this._register_date = register_date,
        this._voter = voter,
        this._country = country,
        this._city = city,
        this._likes = likes,
        this._intro = intro,
        this._achieved = achieved,
        this._token = token,
        this._uid = uid;

  Map<String, dynamic> getMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['type'] = this.type;
    map['service_duration'] = this.service_duration; 
    map['available'] = this._available ?? true;
    map['auth_login'] = this.auth_login ?? '';
    map['tokenId'] = this.tokenId ?? '';
    map['image'] = this._image ?? '';
    map['package'] = this.package ?? {};
    map['busy_dates'] = this.busyDates ?? [];
    map['username'] = this.username;
    map['customers'] = this.customers ?? 0;
    map['acheived'] = this.achieved?.toInt() ?? 0;
    map['intro'] = this._intro ?? '';
    map['favorite_count'] = this.favorite_count ?? 0;
    map['location'] = this._location ?? [];
    map['name'] = this._name ?? '';
    map['visitors'] = this.visitors ?? 0;
    map['points'] = this._points ?? 0;
    map['reg_date'] = this.register_date.toString();
    map['rating'] = this._rating ?? 0;
    map['phone'] = this._phone;
    map['city'] = this._city;
    map['country'] = this._country;
    map['voter'] = this.voter?.toInt() ?? 0;
    map['email'] = this.email ?? '';
    map['likes'] = this.likes?.toInt() ?? 0;
    map['achieved'] = this.achieved ?? 0;
    map['services'] = this.servicespro ?? {};
    map['token'] = this.token;
    map['_id'] = this.uid ?? '';
    return map;
  }

  ModelBeautyProvider.fromMap(Map<String, dynamic> data) {
    _available = data['available'] ?? true;
    _image = data['image'] ?? '';
    service_duration = data['service_duration'];
    _intro = data['intro'] ?? '';
    type = data['type'] ?? 1;
    username = data['username'];
    customers = data['customers'].toDouble() ?? 0;
    // package = data['package'] ?? {};
    _location = data['location'] == [] ? [1, 2] : data['location'];
    _name = data['name'] ?? '';
    favorite_count = data['favorite_count'] ?? 0;
    if (data['tokenId'] != null) tokenId = data['tokenId'];
    email = data['email'] ?? '';
    _points = data['points'] ?? 0;
    package = data['package'] ?? {};
    visitors = data['visitors'] ?? 0;
    _register_date =
        DateTime.parse(data['reg_date']) ?? DateTime.now().toLocal();
    _rating = data['rating'].toDouble() ?? 0;
    _phone = data['phone'] ?? '';
    // _prices = Map<String, dynamic>.from(data['prices']);
    _voter = data['voter'] ?? 0;
    _city = data['city'] ?? '';
    _country = data['country'] ?? "";
    _likes = data['likes'] ?? 0;
    _achieved = data['_achieved'] ?? 0;
    _uid = data['_id'] ?? '';
    busyDates = getBustyDates(data['busy_dates']);

    _token = data['token'] ?? '';
    servicespro = data['services'] == null
        ? {}
        : Map<String, dynamic>.from(data['services']);
    // getAllServices(servicespro);
  }

  List<Map<String, DateTime>> getBustyDates(List<dynamic> myList) {
    return myList.length == 0
        ? []
        : myList
            .map((dateObject) => {
                  'from': DateTime.parse(dateObject['from']),
                  'to': DateTime.parse(dateObject['to'])
                })
            .toList();
    // .cast<List<Map<String, DateTime>>>();
  }

  // getAllServices(Map<String, dynamic> servicess) {
  //   Map<String, dynamic> finalResult = Map<String, dynamic>();
  //   servicess.forEach((k, v) {
  //     Map<String, dynamic>.from(v).forEach((kk, vv) {
  //       finalResult[kk] = vv;
  //       print("key is ${kk}, value is: ${vv.toString()} ");
  //     });
  //   });
  // }
  /**
   * Setters 
   */
/**
 * 
 * method converter to get mapped value
 */
  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();

  //   map['gender'] = _geder;
  //   map['certificate'] = _certificate;
  //   map['region'] = _region;
  //   return map;
  // }

  bool get available => _available;

  set available(bool available) {
    _available = available;
  }

  String get image => _image;

  set image(String image) {
    _image = image;
  }

  String get intro => _intro;

  set intro(String intro) {
    _intro = intro;
  }

  List<dynamic> get location => _location;

  set location(List<dynamic> location) {
    _location = location;
  }

  String get name => _name;

  set name(String name) {
    _name = name;
  }

  int get points => _points;

  set points(int points) {
    _points = points;
  }

  double get rating => _rating;

  set rating(double rating) {
    _rating = rating;
  }

  DateTime get register_date => _register_date;

  set register_date(DateTime register_date) {
    _register_date = register_date;
  }

  String get phone => _phone;

  set phone(String phone) {
    _phone = phone;
  }
}
