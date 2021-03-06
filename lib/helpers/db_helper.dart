import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class DBHelper {
  static Future<Database> database() async {
    Directory appDir = await syspaths.getApplicationDocumentsDirectory();
    // final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(appDir.path, 'places3.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL)
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }
}
