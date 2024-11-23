// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
//
// import '../helpers/database_helper.dart';
//
// Future<void> initializeAppServices(GetIt sl, bool firstInit) async {
//   if (firstInit) {
//     WidgetsFlutterBinding.ensureInitialized();
//   }
//
//   final db = await DatabaseHelperImpl.instance();
//   sl.registerLazySingleton<DatabaseHelper>(
//       dispose: (db) => db.close(), () => db);
// }
