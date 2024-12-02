import 'package:flutter/material.dart';

import './src/app.dart';
import 'src/core/service_locator/service_locator.dart';

void main() async{
  await initializeApp();
  runApp(const App());
}
