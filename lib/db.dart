import 'package:sqflite/sqflite.dart';
import 'dart:core';

Future initializeDb() async {
  var databasesPath = await getDatabasesPath();
  String path = '$databasesPath/hatsuoh_app.db';

  await deleteDatabase(path);
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE Collection (id INTEGER PRIMARY KEY, title TEXT, description TEXT,)');
  });

  List<Map> list = await database.rawQuery('SELECT * FROM Collection');
  print(list);
}
