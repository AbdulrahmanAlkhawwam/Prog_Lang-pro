// import 'dart:async';
//
// import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart';
//
// import '../constants/strings.dart';
//
// abstract class DatabaseHelper {
//   Future<List<Map<String, dynamic>>> getData(String table,
//       {String? where, List? args, String? orderBy});
//
//   Future<int> insert(String table, Map<String, dynamic> data);
//
//   Future<int> update(String table, Map<String, Object?> values,
//       {String? where, List? args});
//
//   Future<int> delete(String table, {String? where, List? args});
//
//   Future<dynamic> sum(String column, String table);
//
//   Future<void> close();
// }
//
// class DatabaseHelperImpl implements DatabaseHelper {
//   late final Database _db;
//
//   DatabaseHelperImpl._(this._db);
//
//   static Future<DatabaseHelperImpl> instance() async {
//     final dbPath = await getDatabasesPath();
//     final database = await openDatabase(
//       path.join(dbPath, databaseFile),
//       onCreate: onCreate,
//       version: 1,
//     );
//     return DatabaseHelperImpl._(database);
//   }
//
//   @override
//   Future<List<Map<String, dynamic>>> getData(String table,
//           {String? where, List? args, String? orderBy}) async =>
//       _db.query(table, where: where, whereArgs: args, orderBy: orderBy);
//
//   @override
//   Future<int> insert(String table, Map<String, dynamic> data) async =>
//       _db.insert(conflictAlgorithm: ConflictAlgorithm.replace, table, data);
//
//   @override
//   Future<int> update(String table, Map<String, Object?> values,
//           {String? where, List? args}) async =>
//       _db.update(table, values, where: where, whereArgs: args);
//
//   @override
//   Future<int> delete(String table, {String? where, List? args}) async =>
//       _db.delete(table, where: where, whereArgs: args);
//
//   @override
//   Future<void> close() async => await _db.close();
//
//   static FutureOr<void> onCreate(Database db, int version) async {
//     await db.execute(
//       """CREATE TABLE $categoriesTable(
//       id                TEXT PRIMARY KEY                      NOT NULL,
//       name              TEXT                                  NOT NULL,
//       type              TEXT                                  NOT NULL
//       -- type like ( income / payment )
//     )""",
//     );
//     await db.execute(
//       """CREATE TABLE $walletsTable(
//       id                TEXT PRIMARY KEY                      NOT NULL,
//       name              TEXT                                  NOT NULL
//     )""",
//     );
//     await db.execute(
//       """CREATE TABLE $operationsTable(
//       id                TEXT PRIMARY KEY                      NOT NULL,
//       name              TEXT                                  NOT NULL,
//       value             DOUBLE                                NOT NULL,
//       description       TEXT                                  ,
//       category_id       TEXT                                  NOT NULL,
//       wallet_id         TEXT                                  NOT NULL,
//       date              Date                                  NOT NULL,
//       -- date like ( 2024-05-10 PM 10:45 000Z )
//       type              TEXT                                  NOT NULL,
//       -- type like ( income / payment )
//       FOREIGN KEY (wallet_id) REFERENCES wallets (id),
//       FOREIGN KEY (category_id) REFERENCES categories (id)
//     )""",
//     );
//   }
//
//   @override
//   Future sum(String column, String table) async =>
//       (await _db.rawQuery("SELECT SUM($column) AS result FROM $table"))
//           .firstOrNull?["result"] ??
//       0;
// }
