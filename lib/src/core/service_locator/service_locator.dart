import 'package:get_it/get_it.dart';

import './core_services.dart';
import './auth_services.dart';
import './product_services.dart';
import './main_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp() async {
  await initializeCoreServices(sl);
  await initializeAuthServices(sl);
  await initializeProductServices(sl);
  await initializeMainServices(sl);
}
