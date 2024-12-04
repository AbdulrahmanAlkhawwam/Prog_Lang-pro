import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './src/app.dart';
import 'src/core/service_locator/service_locator.dart';

void main() async {
  await initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const App());
}
