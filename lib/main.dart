import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import './src/app.dart';
import 'src/core/service_locator/service_locator.dart';

void main() async => await initializeApp().then((_) => runApp(
      EasyLocalization(
        supportedLocales: [Locale('ar'), Locale('en')],
        fallbackLocale: Locale('ar'),
        useOnlyLangCode: true,
        path: 'assets/locales',
        child: const App(),
      ),
    ));
