import 'package:hive/hive.dart';
part 'token.g.dart'; 

@HiveType(typeId: 2)
class DBLocalToken {
  @HiveField(0)
  String token = '';
}
