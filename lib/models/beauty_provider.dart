import 'package:hive/hive.dart';
part 'beauty_provider.g.dart';

enum DefaultAfterAccept { acceptBooking, refuseBooking }

enum DefaultAccept { accept, refuse }

@HiveType(typeId: 1)
class ModelBeautyProvider extends HiveObject {
  DefaultAccept defaultAcceptType = DefaultAccept.refuse;

  DefaultAfterAccept defaultAfterAcceptType = DefaultAfterAccept.refuseBooking;
  @HiveField(0)
  int TYPE_SALON = 1;
  @HiveField(1)
  int TYPE_INDIVIDUAL = 1;
  // @HiveField(2)
  // String? firebaseUid = '';

  @HiveField(2)
  int? type = 1; //whether it was a salon or a simple woman 1 for salon
  @HiveField(3)
  bool? available = true;
  @HiveField(4)
  String? image;
  @HiveField(5)
  double? customers;
  @HiveField(6)
  String? intro;
  @HiveField(7)
  String? email;

  @HiveField(8)
  List<double>? location;
  @HiveField(9)
  String? name;
  @HiveField(10)
  int? voter;
  @HiveField(11)
  String? username;
  @HiveField(12)
  String? uid = '';
  @HiveField(13)
  String? tokenId; // this is the jwt token for authority
  @HiveField(14)
  int? achieved;
  @HiveField(15)
  String? firebase_uid; // only one time firebase token for login
  @HiveField(16)
  String? city;
  @HiveField(17)
  int? points;
  @HiveField(18)
  int? favorite_count;
  @HiveField(19)
  int? visitors;
  @HiveField(20)
  DateTime? register_date;
  @HiveField(21)
  double? rating;
  @HiveField(22)
  Map<String, dynamic>? package;

  @HiveField(23)
  bool? default_accept;
  @HiveField(24)
  int? default_after_accept;
  @HiveField(25)
  String? phone;
  @HiveField(26)
  String? token; // notification token

  @HiveField(27)
  String? country;
  @HiveField(28)
  int? likes;

  ModelBeautyProvider.empty();

  ModelBeautyProvider(
      {Map<String, dynamic>? prices,
      List<double>? location,
      bool? available,
      String? image,
      int? type,
      bool? default_accept,
      String? email,
      String? token,
      Map<String, dynamic>? package,
      String? intro,
      String? name,
      double? customers,
      int? points,
      int? default_after_accept,
      String? tokenId,
      List<Map<String, DateTime>>? busyDates,
      int? favorite_count,
      String? firebase_uid,
      double? rating,
      DateTime? register_date,
      int? voter,
      String? country,
      int? likes,
      int? visitors,
      // String? firebaseUid,
      String? city,
      String? uid,
      String? username,
      int? achieved,
      String? phone})
      : this.location = location,
        this.name = name,
        this.email = email,
        this.visitors = visitors,
        this.username = username,
        this.package = package,
        this.favorite_count = favorite_count,
        this.points = points,
        this.type = type,
        this.default_accept = default_accept,
        this.tokenId = tokenId,
        this.customers = customers,
        // this.firebaseUid = firebaseUid,
        this.rating = rating,
        this.default_after_accept = default_after_accept,
        this.firebase_uid = firebase_uid,
        this.phone = phone,
        this.available = available,
        this.image = image,
        this.register_date = register_date,
        this.voter = voter,
        this.country = country,
        this.city = city,
        this.likes = likes,
        this.intro = intro,
        this.achieved = achieved,
        this.token = token,
        this.uid = uid;

  Map<String, dynamic> getMap() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['type'] = this.type;
    map['default_after_accept'] = this.default_after_accept?.toInt();
    map['available'] = this.available ?? true;
    map['firebase_uid'] = this.firebase_uid ?? '';
    map['tokenId'] = this.tokenId ?? '';
    map['default_accept'] = this.default_accept;
    map['image'] = this.image ?? '';
    map['package'] = this.package ?? {};
    map['username'] = this.username;
    map['customers'] = this.customers ?? 0;
    map['acheived'] = this.achieved?.toInt() ?? 0;
    map['intro'] = this.intro ?? '';
    map['lng'] = this.location?.first;
    map['lat'] = this.location?.last;
    map['favorite_count'] = this.favorite_count ?? 0;
    map['location'] = location;
    map['name'] = this.name ?? '';
    map['visitors'] = this.visitors ?? 0;
    map['points'] = this.points ?? 0;
    // map['firebase_uid'] = this.firebaseUid ?? "";
    map['reg_date'] = this.register_date?.toString();
    map['rating'] = this.rating ?? 0;
    map['phone'] = this.phone;
    map['city'] = this.city;
    map['country'] = this.country;
    map['voter'] = this.voter?.toInt() ?? 0;
    map['email'] = this.email ?? '';
    map['likes'] = this.likes?.toInt() ?? 0;
    map['achieved'] = this.achieved ?? 0;
    map['token'] = this.token;
    map['_id'] = this.uid ?? '';
    return map;
  }

  ModelBeautyProvider.fromMap(Map<String, dynamic> data) {
    available = data['available'] ?? true;
    image = data['image'] ?? '';
    default_after_accept = data['default_after_accept'];
    default_accept = data['default_accept'];
    defaultAcceptType = getDefaultAccept(data['default_accept']);
    defaultAfterAcceptType =
        getDefaultAfterAccept(data['default_after_accept']);
    intro = data['intro'] ?? '';
    type = data['type'] ?? 1;
    username = data['username'] ?? "";
    customers = data['customers'].toDouble() ?? 0;
    tokenId = data['tokenId'];
    // package = data['package'] ?? {};
    ///[todo ] add the location & check
    location = data['location'] == null
        ? []
        : [
            data['location']['coordinates'][0],
            data['location']['coordinates'][1]
          ];
    // location = data['location'] == null
    //     ? [1, 2]
    //     : List.castFrom<dynamic, double>(data['location']['coordinates']);
    name = data['name'] ?? '';
    favorite_count = data['favorite_count'] ?? 0;
    if (data['tokenId'] != null) tokenId = data['tokenId'];
    email = data['email'] ?? '';
    points = data['points'] ?? 0;
    package = data['package'] ?? {};
    visitors = data['visitors'] ?? 0;
    // firebaseUid = data['firebase_uid'] ?? "";
    register_date = data['reg_date'] != null
        ? DateTime.parse(data['reg_date'])
        : DateTime.now().toLocal();
    rating = data['rating'].toDouble() ?? 0;
    phone = data['phone'] ?? '';
    // _prices = Map<String, dynamic>.from(data['prices']);
    voter = data['voter'] ?? 0;
    city = data['city'] ?? '';
    country = data['country'] ?? "";
    likes = data['likes'] ?? 0;
    achieved = data['_achieved'] ?? 0;
    uid = data['_id'] ?? '';

    token = data['token'] ?? '';

    // getAllServices(servicespro);
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

  DefaultAccept getDefaultAccept(bool defaultAccept) {
    return defaultAccept ? DefaultAccept.accept : DefaultAccept.refuse;
  }

  DefaultAfterAccept getDefaultAfterAccept(int defaultAfterAccept) {
    switch (defaultAfterAccept) {
      case 2:
        return DefaultAfterAccept.acceptBooking;
      default:
        return DefaultAfterAccept.refuseBooking;
    }
  }
}
