import 'dart:async';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

import '../constants/strings.dart';

abstract class DatabaseHelper {
  Future<List<Map<String, dynamic>>> getData(String table,
      {String? where, List? args, String? orderBy});

  Future<int> insert(String table, Map<String, dynamic> data);

  Future<int> update(String table, Map<String, Object?> values,
      {String? where, List? args});

  Future<int> delete(String table, {String? where, List? args});

  Future<void> close();
}

class DatabaseHelperImpl implements DatabaseHelper {
  late final Database _db;

  DatabaseHelperImpl._(this._db);

  static Future<DatabaseHelperImpl> instance() async {
    final dbPath = await getDatabasesPath();
    final database = await openDatabase(
      path.join(dbPath, databaseFile),
      onCreate: onCreate,
      version: 1,
    );
    return DatabaseHelperImpl._(database);
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String table,
          {String? where, List? args, String? orderBy}) async =>
      _db.query(table, where: where, whereArgs: args, orderBy: orderBy);

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async =>
      _db.insert(conflictAlgorithm: ConflictAlgorithm.replace, table, data);

  @override
  Future<int> update(String table, Map<String, Object?> values,
          {String? where, List? args}) async =>
      _db.update(table, values, where: where, whereArgs: args);

  @override
  Future<int> delete(String table, {String? where, List? args}) async =>
      _db.delete(table, where: where, whereArgs: args);

  @override
  Future<void> close() async => await _db.close();

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute(
      """CREATE TABLE $cartTable(
          id            INTEGER PRIMARY KEY       NOT NULL,
          store_Id      INTEGER                   NOT NULL, 
          category_Id   INTEGER                   NOT NULL,
          quantity      INTEGER                   NOT NULL,
          image         TEXT                      NOT NULL,
          price         TEXT                      NOT NULL,
          product_name  TEXT                      NOT NULL
      )""",
    );
  }
}
