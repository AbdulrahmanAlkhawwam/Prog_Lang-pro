import 'package:get_it/get_it.dart';

import './core_services.dart';
import './auth_services.dart';
import './shops_services.dart';
import './product_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp() async {
  await initializeCoreServices(sl);
  await initializeAuthServices(sl);
  await initializeShopServices(sl);
  await initializeProductServices(sl);
}
