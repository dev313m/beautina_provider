import 'package:beauty_order_provider/models/notification.dart';
import 'package:beauty_order_provider/prefrences/last_notification_date.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

/*
 * This class is the sqflite layer to the app, it includes CRUD* operations for the table Notification
*/

class NotificationHelper {
  String _tableName = 'notification';
  static Database _database;

/**
 * These are the table column to be generated 
 */
  String colId = 'id';
  String title = 'title';
  String describ = 'describ';
  String createDate = 'create_date';
  String readDate = 'read_date';
  String status = 'status';
  String type = 'type';
  String icon = 'icon';
  String image = 'image';

  // String colGender = 'gender';
  // String colCertificate = 'certificate';
  // String colRegion = 'region';

  /// This is the singleton declaration

  static NotificationHelper _NotificationHelper;
  NotificationHelper._createInstance();

  factory NotificationHelper() {
    if (_NotificationHelper == null) {
      _NotificationHelper = NotificationHelper._createInstance();
    }
    return _NotificationHelper;
  }

  Future<Database> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'notification.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $_tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, $describ TEXT, $createDate INTEGER, $readDate INTEGER,' +
            '$status INTEGER, $type TEXT, $icon TEXT, $image TEXT' +
            ') ');
  }

/**
 * getPrefrencesList() is to get all table list
 */
  Future<List<MyNotification>> getNotificationList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> list =
        await db.query(_tableName, orderBy: '$colId DESC'); //DESC
    return list.map((f) => MyNotification.fromMapObject(f)).toList();
  }

/**
 * insertPrefrences() method is to insert a prefrence 
 */
  Future<int> insertNotification(MyNotification notification) async {
    Database db = await this.database;
    int result = await db.insert(_tableName, notification.toMap());
    await updateLastNotificationDate(notification.createDate);
    return result;
  }

  // Future<bool> checkIfNew(String notiDate) async {
  //   String lastDate = await getLastNotifyDate();
  //   int result = DateTime.parse(lastDate).compareTo(DateTime.parse(notiDate));
  //   if (result < 0) return true;
  //   return false;
  // }

  ///This is to save last notification date inside the database
  Future updateLastNotificationDate(String notificationDate) async {
    await setPrefrenceLastNotifyDate(notificationDate);
  }

/**
 * Updating a prefrence
 */
  Future<int> updateNotification(MyNotification notification) async {
    Database db = await this.database;
    notification.status = 1;
    return await db.update(
      _tableName,
      notification.toMap(),
      where: '$colId = ?',
      whereArgs: [notification.colId],
    );
  }

  updateListToRead(List<MyNotification> list) async {
    list.map((noti) async {
      if (noti.status == 0) await updateNotification(noti);
    }).toList();
  }

  /**
   * Delete a prefrence
   */
  Future<int> deleteNotification(MyNotification notification) async {
    Database db = await this.database;
    return await db.delete(_tableName,
        where: '$colId = ?', whereArgs: [notification.colId]);
  }

/**Get the count of the table raws
 * 
 * 
 */

  // Future<int> count() async {
  //   Database db = await this.database;
  //   List<Map<String, dynamic>> x =
  //       await db.rawQuery('SELECT COUNT (*) FROM $_tableName');
  //   return Sqflite.firstIntValue(x);
  // }
/**
 *      
 * Add to database only if raws are 3 or just replace. 
 */

  // Future<int> addPrefrenceOnly(Prefrence prefrence) async {
  //   Database db = await this.database;
  //   await getPrefrencesList().then((data) {
  //     if (data.length < 3) {
  //       insertPrefrences(prefrence);
  //     } else {
  //       deletePrefrence(new Prefrence.fromMapObject(data.elementAt(2)));
  //       insertPrefrences(prefrence);
  //     }
  //   });
  // }
}
