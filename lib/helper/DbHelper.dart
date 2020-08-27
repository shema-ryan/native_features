import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sql.dart';

class DbHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'places.db'), version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY , title TEXT , image TEXT)');
    });
  }

  static Future<void> insert(
      String table, Map<String, dynamic> userData) async {
    Database db = await DbHelper.database();
    await db.insert(table, userData,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetch(String table) async {
    Database db = await DbHelper.database();
    return db.query(table);
  }
}
