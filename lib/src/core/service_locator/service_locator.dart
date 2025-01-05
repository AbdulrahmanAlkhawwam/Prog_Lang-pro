import 'package:get_it/get_it.dart';

import './auth_services.dart';
import './cart_services.dart';
import './core_services.dart';
import './favorite_services.dart';
import './file_services.dart';
import './shop_services.dart';
import './product_services.dart';
import './main_services.dart';
import './settings_services.dart';
import './order_services.dart';
import './user_services.dart';

final sl = GetIt.instance;

Future<void> initializeApp() async {
  await initializeAuthServices(sl);
  await initializeCartServices(sl);
  await initializeCoreServices(sl);
  await initializeFavoriteServices(sl);
  await initializeFileServices(sl);
  await initializeMainServices(sl);
  await initializeOrderServices(sl);
  await initializeProductServices(sl);
  await initializeSettingsServices(sl);
  await initializeShopServices(sl);
  await initializeUserServices(sl);
}
