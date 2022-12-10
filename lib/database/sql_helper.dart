import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/foundation.dart';

class SQLHelper {
  // Creating Tabale
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE teacher(
        id INTEGER PRIMARY KEY NOT NULL,
        name TEXT,
        phone INTEGER,
        job TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  // Creating Database
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'registor.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("Table Creating");
        await createTables(database);
      },
    );
  }

  // Insert Data into the database
  static Future<int> createItem(
      int tId, String tName, int tPhone, String tJob) async {
    final db = await SQLHelper.db();

    final data = {'id': tId, 'name': tName, 'phone': tPhone, 'job': tJob};
    final id = await db.insert('teacher', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Get All Data from the database
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('teacher', orderBy: "id");
  }
}
