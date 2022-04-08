class ModelThread {
  String? id;
  List<String>? images;
  List<String>? videos;
  String? title;
  String? detail;
  int? type;
  String? poster_icon;
  DateTime? post_date;
  String? poster_name;
  int? category;
  ModelThread.fromMap(Map<String, dynamic> map) {
    this.id = map['id'] as String?;
    this.images = map['images'].toString().split('~');
    this.videos = map['videos'].toString().split('~');
    this.title = map['title'] as String?;
    this.detail = map['detail'] as String?;
    this.type = int.parse(map['TYPE']);
    this.poster_icon = map['poster_icon'] as String?;
    this.post_date = DateTime.parse(map['post_date']);
    this.poster_name = map['poster_name'] as String?;
    this.category = int.parse(map['category']);
  }
}
