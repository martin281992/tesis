import 'dart:io';

import 'package:apptagit/src/models/sociosModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._private();

  DBProvider._private();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'TagitDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Socios('
          'id INTEGER PRIMARY KEY, '
          'correo TEXT,'
          'informacion TEXT,'
          'estado TEXT'
          ')');
    });
  }

  nuevoSocio(SociosModel nuevoSocio) async {
    final db = await database;
  }
}
