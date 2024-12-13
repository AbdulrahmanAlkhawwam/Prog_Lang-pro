import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../constants/env.dart';
import '../helpers/database_helper.dart';
import '../helpers/http_helper.dart';
import '../helpers/storage_helper.dart';

Future<void> initializeCoreServices(GetIt sl) async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();

  final db = await DatabaseHelperImpl.instance();
  sl.registerLazySingleton<DatabaseHelper>(
    () => db,
    dispose: (db) => db.close(),
  );

  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => preferences);

  sl.registerLazySingleton<StorageHelper>(() => StorageHelperImpl(sl()));

  sl.registerLazySingleton<HttpHelper>(
    () => HttpHelperImpl(
      host: Env.host,
      basePath: "/api",
      client: http.Client(),
      storage: sl(),
    ),
    dispose: (httpHelper) => httpHelper.close(),
  );
}
